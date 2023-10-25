import datetime
from google.oauth2.service_account import Credentials
from google_auth_oauthlib.flow import InstalledAppFlow
from google.auth.transport.requests import Request
from googleapiclient.discovery import build
import requests

# Google Calendar APIの認証情報
creds = None
# トークンが保存されるファイル名
token_file = 'token.json'
if os.path.exists(token_file):
    creds = Credentials.from_authorized_user_file(token_file)
if not creds or not creds.valid:
    if creds and creds.expired and creds.refresh_token:
        creds.refresh(Request())
    else:
        flow = InstalledAppFlow.from_client_secrets_file(
            'credentials.json', ['https://www.googleapis.com/auth/calendar'])
        creds = flow.run_local_server(port=0)
    # 次回のためにトークンを保存する
    with open(token_file, 'w') as token:
        token.write(creds.to_json())

# Google Calendar API クライアントの初期化
service = build('calendar', 'v3', credentials=creds)

# Notion APIの認証情報
NOTION_TOKEN = "your-notion-integration-token"
NOTION_VERSION = "2023-06-30"  # API version
HEADERS = {
    "Authorization": f"Bearer {NOTION_TOKEN}",
    "Notion-Version": NOTION_VERSION,
}

# Google Calendarからイベントを取得
calendar_id = 'primary'
time_min = datetime.datetime.utcnow().isoformat() + 'Z'  # 'Z' indicates UTC time
events_result = service.events().list(
    calendarId=calendar_id,
    timeMin=time_min,
    singleEvents=True,
    orderBy='startTime'
).execute()
events = events_result.get('items', [])

# Notionにイベントを書き込む
for event in events:
    start = event['start'].get('dateTime', event
