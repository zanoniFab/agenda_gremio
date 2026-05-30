import json
import os


def main(event, context):
    sender_email = os.environ["SENDER_EMAIL"]
    recipient_email = os.environ["RECIPIENT_EMAIL"]

    payload = {
        "message": "Agenda Gremio alert routine executed.",
        "sender_email": sender_email,
        "recipient_email": recipient_email,
        "event": event,
    }

    print(json.dumps(payload, ensure_ascii=True))

    return {
        "statusCode": 200,
        "body": "Agenda Gremio alert routine executed.",
    }
