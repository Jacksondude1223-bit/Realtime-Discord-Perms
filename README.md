
# ⚡ Ace Sync Project

> The only system that provides true **REALTIME Discord-to-FiveM ACE/Groups** permission synchronization.

**Powered by passion — built to elevate the FiveM development community.**

---

## 🧠 How It Works

The **Ace Sync Project** connects your **Discord server roles** to your **FiveM ACE permissions** and keeps them synchronized in **real-time**. This ensures that any role changes in Discord are instantly reflected in your game server without needing the player to rejoin or run a command.

### 📊 System Architecture

```
Discord Role Change
        │
        ▼
 Discord Bot (guildMemberUpdate)
        │
        ▼
 HTTP POST Request to FiveM
        │
        ▼
 FiveM HTTP Handler Receives Role Payload
        │
        ▼
 Match Player By Discord ID & Apply Roles
        │
        ▼
 Client Receives Updated Roles & UI Feedback
```

---

## 🛠️ Setup Guide

### 1. FiveM Resource

Place the `fivem_resource` folder in your server's `resources` directory and ensure it starts:

```bash
ensure fivem_resource
```

> Make sure the HTTP handler (`fivem_http_handler/http_handler.lua`) is also loaded on the server side.

### 2. Discord Bot

In the `discord_bot/` folder:
- Install dependencies:

```bash
npm install
```

- Create a `.env` file with:

```env
DISCORD_TOKEN=your_discord_bot_token
FIVEM_API_URL=http://localhost:30120/role-sync
```

- Start the bot:

```bash
node bot.js
```

### 3. Permissions in Discord

Ensure your bot has the `Guild Members` intent enabled in the Discord Developer Portal, and that it has permission to read member roles.

---

## 🔄 Real-Time Sync in Action

When a user’s role is updated in Discord:
1. The bot detects the change and sends the updated roles to the FiveM server.
2. The FiveM server matches the player by Discord ID and triggers a client event.
3. The client receives the new roles and displays a UI message like:
   - ✅ Applied 3 roles

---

## 🔐 Security (Optional)

- Restrict the FiveM HTTP endpoint with an API key or IP whitelist.
- Only allow specific Discord roles to apply ACE groups.

---

## 📁 Project Structure

```
ace_sync_project/
├── fivem_resource/
│   ├── __resource.lua
│   ├── client.lua
│   └── server.lua
├── fivem_http_handler/
│   └── http_handler.lua
├── discord_bot/
│   ├── bot.js
│   ├── .env.example
│   └── package.json
```

---

## 📢 Credits

Made with ❤️ by developers who care about real-time automation, simplicity, and the future of FiveM role integration.
