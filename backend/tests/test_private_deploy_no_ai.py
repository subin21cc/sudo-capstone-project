"""개인 서버 배포(private-deploy): AI 키 없는 운영 기동 — DB 불필요."""
from __future__ import annotations

import pytest
from pydantic import ValidationError

from app.core.config import Settings
from app.services.embedder import factory as embedder_factory
from app.services.recognizer import factory as recognizer_factory


def _prod_no_ai(**kw) -> Settings:
    base = dict(
        _env_file=None, env="prod",
        jwt_secret="a-strong-random-secret-value-for-prod-tests",
        cors_allow_origins="https://app.oncare.com",
        seed_demo_data=False,
        auto_create_tables=False,
        gemini_api_key="",
        recognizer="gemini",
        embedder="gemini",
    )
    base.update(kw)
    return Settings(**base)


def test_prod_without_ai_key_still_blocked_by_default():
    with pytest.raises(ValidationError):
        _prod_no_ai()


def test_prod_without_ai_key_boots_when_allowed():
    s = _prod_no_ai(allow_prod_without_ai=True)
    assert s.is_prod is True
    assert s.missing_ai_config()  # 문제는 그대로 보이지만 기동은 막지 않는다


def test_prod_without_ai_never_falls_back_to_fakes(monkeypatch):
    s = _prod_no_ai(allow_prod_without_ai=True)
    monkeypatch.setattr(recognizer_factory, "get_settings", lambda: s)
    monkeypatch.setattr(embedder_factory, "get_settings", lambda: s)
    with pytest.raises(recognizer_factory.RecognizerUnavailable):
        recognizer_factory.get_recognizer()
    with pytest.raises(recognizer_factory.RecognizerUnavailable):
        recognizer_factory.get_recognizer("stub")
    with pytest.raises(embedder_factory.EmbedderUnavailable):
        embedder_factory.get_embedder()
