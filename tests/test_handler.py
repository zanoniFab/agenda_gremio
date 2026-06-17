import io
import json
import os
import sys
import unittest
from contextlib import redirect_stdout
from pathlib import Path
from unittest.mock import patch


ROOT_DIR = Path(__file__).resolve().parents[1]
LAMBDA_DIR = ROOT_DIR / "infra" / "terraform" / "lambda"
sys.path.insert(0, str(LAMBDA_DIR))

import handler  # noqa: E402


class HandlerTests(unittest.TestCase):
    def test_main_returns_success_response_and_logs_payload(self):
        event = {"source": "unit-test"}
        env = {
            "SENDER_EMAIL": "sender@example.com",
            "RECIPIENT_EMAIL": "recipient@example.com",
        }

        output = io.StringIO()
        with patch.dict(os.environ, env, clear=False), redirect_stdout(output):
            response = handler.main(event, None)

        self.assertEqual(response["statusCode"], 200)
        self.assertEqual(response["body"], "Agenda Gremio alert routine executed.")

        log_payload = json.loads(output.getvalue())
        self.assertEqual(log_payload["sender_email"], env["SENDER_EMAIL"])
        self.assertEqual(log_payload["recipient_email"], env["RECIPIENT_EMAIL"])
        self.assertEqual(log_payload["event"], event)


if __name__ == "__main__":
    unittest.main()
