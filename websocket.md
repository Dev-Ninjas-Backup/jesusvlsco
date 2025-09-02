# Private Chat Jesus

---

# What this is?

- One-to-one private chat between two users.
- Business rules:
    - If conversation exists, participants can message.
    - If conversation **does not** exist:
        - **Admin / Superadmin** may initiate (send the first message) to an employee.
        - **Employee** may initiate only with another **employee** (not admins).
- **Note:** Gateway code currently **does not** enforce the admin/employee initiation restriction. Enforce client-side role check.

---

# Connection

- **Namespace:** `/private`
- **Full URL example:** `https://lgcglobalcontractingltd.com/js/private`

**Auth**

- The gateway accepts JWT in either:
    - `Authorization` header on the socket handshake, **OR**
    - `handshake.auth.token`.
- **Important:** token must be in the format `Bearer <JWT>`

**How client learns current userId**

- On successful authentication the gateway sets `client.data.userId` (from JWT `sub`) and emits:
    - Event: `private:success`
    - Payload: the authenticated `userId` as a **string** (e.g. `"fb57eb85-bc30-4b45-9834-bbf0b035f3e0"`).
- **Clients should store this `userId` from the `private:success` event** and use it when sending `private:send_message` payloads (the gateway checks it matches the token).

---

# Exact events

```tsx
enum PrivateChatEvents {
  ERROR = 'private:error',
  SUCCESS = 'private:success',
  NEW_MESSAGE = 'private:new_message',
  SEND_MESSAGE = 'private:send_message',
  NEW_CONVERSATION = 'private:new_conversation',
  CONVERSATION_LIST = 'private:conversation_list',
  LOAD_CONVERSATIONS = 'private:load_conversations',
  LOAD_SINGLE_CONVERSATION = 'private:load_single_conversation'
}
```

---

# Event contracts — exactly what to send & expect

### `private:load_conversations`

- **Client → Server:** emit `"private:load_conversations"` with **no payload**.
- **Server → Client:** emits `"private:conversation_list"` with an array of conversation summaries (see example below).

**Example `private:conversation_list` item**

```json
{
  "type":"private",
  "chatId":"659c25fa-1da2-48fc-b096-819a0015d8e6",
  "participant": {
    "id":"d4cd95ef-4102-442f-aa8f-d820a11924ac",
    "profile": { "profileUrl":"http://...", "firstName":"Sajib", "lastName":"Doe" }
  },
  "lastMessage": {
    "id":"e07b5c20-9bf1-4eb4-9c48-a8f5ca16b8f6",
    "content":"gfgfjgfj",
    "conversationId":"659c25fa-1da2-48fc-b096-819a0015d8e6",
    "senderId":"fb57eb85-bc30-4b45-9834-bbf0b035f3e0",
    "fileId": null,
    "isRead": false,
    "createdAt":"2025-09-01T02:55:24.602Z",
    "sender": { "id":"fb57eb85-...", "profile": { "profileUrl": null, "firstName":"", "lastName":"" } },
    "file": null
  },
  "updatedAt":"2025-09-01T02:55:24.606Z",
  "isRead": false
}

```

---

### `private:load_single_conversation` ← **NEW (added)**

- **Purpose:** Load full conversation details **(participants + entire message history)** for a given conversation id.
- **Client → Server:** emit `"private:load_single_conversation"` with payload = **string** `conversationId`.
    - Example:
        
        ```jsx
        socket.emit('private:load_single_conversation', '659c25fa-1da2-48fc-b096-819a0015d8e6');
        ```
        
- **Server → Client:** emits `"private:new_conversation"` with the full conversation object (this is the same event used elsewhere for refreshed lists; in this case payload is a single conversation object).
- **`private:new_conversation` payload (single conversation)** — exact shape returned by `getPrivateConversationWithMessages`:

```json
{
  "conversationId":"659c25fa-1da2-48fc-b096-819a0015d8e6",
  "participants":[
    { "id":"fb57eb85-...", "profile": { "firstName":"", "lastName":"", "profileUrl": null } },
    { "id":"d4cd95ef-...", "profile": { "firstName":"Sajib", "lastName":"Doe", "profileUrl":"http://..." } }
  ],
  "messages":[
    {
      "id":"e07b5c20-9bf1-4eb4-9c48-a8f5ca16b8f6",
      "content":"first message here",
      "conversationId":"659c25fa-1da2-48fc-b096-819a0015d8e6",
      "senderId":"fb57eb85-...",
      "fileId": null,
      "isRead": false,
      "createdAt":"2025-09-01T02:55:24.602Z",
      "sender": { "id":"fb57eb85-...", "profile": { "profileUrl": null, "firstName":"", "lastName":"" } },
      "file": null
    }
    // ...ordered by createdAt asc
  ]
}
```

- **Access validation:** server will only return the conversation if the authenticated user (from `client.data.userId`) is one of the conversation participants. If not, client will receive `private:error` (or the gateway-side error message).
- **Notes / usage:**
    - If you don't have `conversationId` yet, use `private:load_conversations` to get chat list and `chatId` from there.
    - Alternatively, `private:send_message` will create a new conversation (if none) and the gateway will emit `private:new_conversation` with refreshed lists — check those to get the new `chatId`.

---

### `private:send_message`

- **Client → Server:** emit `"private:send_message"` with this exact payload shape:

```json
{
  "userId": "<sender-user-id>",  // MUST be the userId received from private:success
  "recipientId": "<recipient-user-id>",
  "dto": { "content": "<text>" },
  "file": null
}
```

- **Gateway validations:**
    - If `client.data.userId !== payload.userId` → gateway emits `private:error` `{ message: 'User ID mismatch' }`.
    - If `userId === recipientId` → gateway emits `private:error` `{ message: 'Cannot send message to yourself' }`.
- **Server behavior (what happens):**
    1. `findConversation(userId, recipientId)`
    2. If none → `createConversation(userId, recipientId)` (gateway will create without role checks).
    3. `sendPrivateMessage(...)` creates the message and message-status entries.
    4. Server emits the created message with event `private:new_message` to **both** users (via rooms `userId` and `recipientId`).
    5. If it was a new conversation, server fetches both users' conversation lists and emits `private:new_conversation` to each with the refreshed lists.
- **Important:** There is **no ack callback** — use the `private:new_message` event as acknowledgement and canonical message.

---

### `private:new_message`

- **Server → Client** (both sender and recipient). Payload is the created message object

```json
{
  "id":"2c514dc3-5b6a-4d1d-92ff-e29b83ab0cd1",
  "content":"gfgfjgfj",
  "conversationId":"659c25fa-1da2-48fc-b096-819a0015d8e6",
  "senderId":"fb57eb85-bc30-4b45-9834-bbf0b035f3e0",
  "fileId": null,
  "isRead": false,
  "createdAt":"2025-09-01T03:07:49.379Z",
  "sender": {
    "id":"fb57eb85-...",
    "profile": { "profileUrl": null, "firstName":"", "lastName":"" }
  },
  "file": null
}
```

- **Client responsibilities:**
    - Replace optimistic/local messages with this server message (use `id` and `createdAt`).
    - **Dedupe** messages by `id` (you might receive the same `private:new_message` multiple times if the same user has multiple sockets/connections).

---

### `private:new_conversation`

- **Server → Client** after sending first message created a conversation.
- **Payload:** refreshed conversation list (same shape as `private:conversation_list`).
- **Also used** as the response target event for `private:load_single_conversation` (when returning a single conversation object).

---

### `private:error` & `private:success`

- **`private:success`** — server → client on successful connect. Payload: `"<userId>"` (string). **Store this value** and use it in `private:send_message`.
- **`private:error`** — server → client for errors (auth, mismatch, self-send, disconnect). Payload: `{ message: string }`.

---

# Important practical notes

- The sender receives `private:new_message` as the confirmation (so treat that as ack).
- `private:load_conversations` result (`private:conversation_list`) includes `lastMessage` with `conversationId` and `senderId` which helps UI to show previews and unread state.
- Use `private:load_single_conversation` when you need the **entire history** (participants + ordered messages) for a specific `conversationId`.

---

# Minimal CODE SAMPLE

```jsx
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Private Chat WebSocket Test (Full)</title>
    <script src="https://cdn.socket.io/4.7.2/socket.io.min.js"></script>
    <style>
      body {
        font-family: Arial, sans-serif;
        padding: 20px;
        display: grid;
        grid-template-columns: 360px 1fr;
        gap: 20px;
      }
      .panel {
        background: #fff;
        border: 1px solid #e6e6e6;
        padding: 12px;
        border-radius: 6px;
      }
      input,
      button,
      select {
        margin: 6px 0;
        width: 100%;
        box-sizing: border-box;
        padding: 8px;
      }
      #log {
        background: #f7f7f7;
        padding: 10px;
        height: 180px;
        overflow-y: auto;
        white-space: pre-wrap;
        border-radius: 4px;
        border: 1px solid #eee;
      }
      #conversations {
        height: 360px;
        overflow-y: auto;
        border-radius: 4px;
        border: 1px solid #eee;
        padding: 8px;
        background: #fafafa;
      }
      .conv {
        padding: 8px;
        border-bottom: 1px solid #eee;
        cursor: pointer;
      }
      .conv:hover {
        background: #f0f8ff;
      }
      .selected {
        background: #e6f3ff !important;
      }
      #messages {
        height: 360px;
        overflow-y: auto;
        border-radius: 4px;
        border: 1px solid #eee;
        padding: 8px;
        background: #fafafa;
      }
      .msg {
        margin: 6px 0;
        padding: 8px;
        border-radius: 6px;
        background: #fff;
        box-shadow: 0 0 0 1px #f0f0f0 inset;
      }
      .msg.me {
        background: #e8f5e9;
        align-self: flex-end;
      }
      .meta {
        font-size: 12px;
        color: #666;
        margin-bottom: 4px;
      }
    </style>
  </head>
  <body>
    <div class="panel">
      <h3>Connection</h3>
      <label>JWT Token</label>
      <input type="text" id="token" placeholder="Enter your JWT token here" />

      <label>Server URL</label>
      <input type="text" id="serverUrl" value="http://localhost:3000" />

      <button id="connectBtn">Connect</button>

      <div style="margin-top: 12px">
        <strong>Authenticated userId:</strong>
        <div id="currentUserId" style="word-break: break-all; color: #0b6">
          — not connected —
        </div>
      </div>

      <hr />

      <h4>Conversation controls</h4>
      <button id="loadConvosBtn">Load all conversations</button>

      <label>Conversation ID (open)</label>
      <input
        type="text"
        id="conversationIdInput"
        placeholder="paste conversationId or click a conversation"
      />

      <button id="openConversationBtn">Open conversation (load history)</button>

      <label>Find conversation by participantId</label>
      <input
        type="text"
        id="findByParticipant"
        placeholder="other user id (find chatId)"
      />
      <button id="findConversationBtn">Find & Open conversation</button>

      <hr />

      <h4>Send message</h4>
      <label>Recipient ID</label>
      <input
        type="text"
        id="recipientId"
        placeholder="recipient user id (use selected conversation participant if open)"
      />

      <label>Message</label>
      <input type="text" id="message" placeholder="Enter message" />

      <button id="sendMsgBtn">Send message</button>

      <hr />
      <h4>Logs</h4>
      <div id="log"></div>
    </div>

    <div class="panel">
      <h3>Conversations</h3>
      <div id="conversations"></div>

      <h3 style="margin-top: 12px">Messages (opened conversation)</h3>
      <div id="messages"></div>
    </div>

    <script>
      // ======= state =======
      let socket = null;
      let currentUserId = null; // set from private:success
      let conversationList = []; // array from private:conversation_list / private:new_conversation (when array)
      const conversationsById = {}; // chatId -> summary
      const messagesByConversation = {}; // chatId -> { messages: [], ids: Set() }
      let currentConversationId = null;

      // ======= UI helpers =======
      const logBox = document.getElementById('log');
      function log(msg) {
        const time = new Date().toISOString().replace('T', ' ').split('.')[0];
        logBox.textContent += `[${time}] ${msg}\n`;
        logBox.scrollTop = logBox.scrollHeight;
      }

      function renderConversationList() {
        const container = document.getElementById('conversations');
        container.innerHTML = '';
        conversationList.forEach((conv) => {
          conversationsById[conv.chatId] = conv;
          const d = document.createElement('div');
          d.className =
            'conv' + (conv.chatId === currentConversationId ? ' selected' : '');
          d.dataset.chatId = conv.chatId;
          const name =
            conv.participant?.profile?.firstName || conv.participant?.id;
          const last = conv.lastMessage
            ? conv.lastMessage.content
            : '(no messages)';
          d.innerHTML = `<strong>${name}</strong><div style="font-size:12px;color:#666">${last}</div><div style="font-size:11px;color:#999;margin-top:6px">chatId: ${conv.chatId}</div>`;
          d.onclick = () => {
            document.getElementById('conversationIdInput').value = conv.chatId;
            openConversation(conv.chatId);
          };
          container.appendChild(d);
        });
      }

      function renderMessagesForCurrentConversation() {
        const messagesEl = document.getElementById('messages');
        messagesEl.innerHTML = '';
        if (!currentConversationId) {
          messagesEl.textContent = 'No conversation opened';
          return;
        }
        const store = messagesByConversation[currentConversationId];
        if (!store || store.messages.length === 0) {
          messagesEl.textContent = 'No messages';
          return;
        }
        store.messages.forEach((m) => {
          const el = document.createElement('div');
          el.className = 'msg' + (m.senderId === currentUserId ? ' me' : '');
          const meta = document.createElement('div');
          meta.className = 'meta';
          const senderName =
            m.sender?.profile?.firstName || m.sender?.id || m.senderId;
          meta.textContent = `${senderName} • ${new Date(m.createdAt).toLocaleString()}`;
          const content = document.createElement('div');
          content.textContent = m.content;
          el.appendChild(meta);
          el.appendChild(content);
          messagesEl.appendChild(el);
        });
        messagesEl.scrollTop = messagesEl.scrollHeight;
      }

      function ensureConversationStore(chatId) {
        if (!messagesByConversation[chatId]) {
          messagesByConversation[chatId] = { messages: [], ids: new Set() };
        }
      }

      function pushMessageToStore(chatId, message) {
        ensureConversationStore(chatId);
        const store = messagesByConversation[chatId];
        if (store.ids.has(message.id)) return false; // dedupe
        store.ids.add(message.id);
        store.messages.push(message);
        // keep sort by createdAt asc (messages created in ascending order typically)
        store.messages.sort(
          (a, b) => new Date(a.createdAt) - new Date(b.createdAt),
        );
        return true;
      }

      // ======= socket handlers & actions =======
      document
        .getElementById('connectBtn')
        .addEventListener('click', connectSocket);
      document
        .getElementById('loadConvosBtn')
        .addEventListener('click', loadConversations);
      document
        .getElementById('openConversationBtn')
        .addEventListener('click', () => {
          const id = document
            .getElementById('conversationIdInput')
            .value.trim();
          if (!id) {
            alert('Please enter conversationId');
            return;
          }
          openConversation(id);
        });
      document
        .getElementById('findConversationBtn')
        .addEventListener('click', () => {
          const other = document
            .getElementById('findByParticipant')
            .value.trim();
          if (!other) {
            alert('enter participant id');
            return;
          }
          // try find in conversationList
          const found = conversationList.find(
            (c) => c.participant?.id === other,
          );
          if (found) {
            document.getElementById('conversationIdInput').value = found.chatId;
            openConversation(found.chatId);
          } else {
            log(
              '❗ No existing conversation found for that participant — you can send a message to create one.',
            );
          }
        });

      document.getElementById('sendMsgBtn').addEventListener('click', () => {
        sendMessage();
      });

      function connectSocket() {
        const token = document.getElementById('token').value.trim();
        const serverUrl = document.getElementById('serverUrl').value.trim();
        if (!token) {
          alert('Please enter a JWT token');
          return;
        }
        if (!serverUrl) {
          alert('Please enter server URL');
          return;
        }

        socket = io(`${serverUrl}/js/private`, {
          auth: { token: `Bearer ${token}` },
          transports: ['websocket'],
        });

        socket.on('connect', () => {
          log('✅ Connected to Private Chat server');
          document.getElementById('connectBtn').disabled = true;
        });

        socket.on('disconnect', (reason) => {
          log('❌ Disconnected: ' + reason);
          document.getElementById('connectBtn').disabled = false;
          currentUserId = null;
          document.getElementById('currentUserId').textContent =
            '— not connected —';
        });

        socket.on('connect_error', (err) => {
          log('⚠️ Connection error: ' + (err?.message || err));
        });

        // Core events
        socket.on('private:success', (userId) => {
          log('✅ Authenticated successfully as user: ' + userId);
          currentUserId = userId;
          document.getElementById('currentUserId').textContent = userId;
        });

        socket.on('private:error', (err) => {
          log('❌ Error: ' + JSON.stringify(err, null, 2));
        });

        socket.on('private:conversation_list', (conversations) => {
          log(
            '📄 Conversation list received (' +
              (conversations?.length || 0) +
              ')',
          );
          conversationList = conversations || [];
          renderConversationList();
        });

        // NEW_CONVERSATION is used both to deliver refreshed conversation lists (when a new conv is created)
        // and also used by the gateway to return a single conversation object (see gateway code).
        socket.on('private:new_conversation', (payload) => {
          if (Array.isArray(payload)) {
            // refreshed conversation list
            log(
              '🆕 Received refreshed conversation list (' +
                payload.length +
                ')',
            );
            conversationList = payload;
            renderConversationList();
          } else if (payload && payload.conversationId) {
            // single conversation with messages (response to load single)
            log('📂 Loaded single conversation: ' + payload.conversationId);
            // store summary (if participant info available)
            conversationsById[payload.conversationId] =
              conversationsById[payload.conversationId] || {};
            // store messages
            ensureConversationStore(payload.conversationId);
            // replace messages
            messagesByConversation[payload.conversationId].messages =
              payload.messages || [];
            messagesByConversation[payload.conversationId].ids = new Set(
              (payload.messages || []).map((m) => m.id),
            );
            currentConversationId = payload.conversationId;
            document.getElementById('conversationIdInput').value =
              currentConversationId;
            renderConversationList();
            renderMessagesForCurrentConversation();
          } else {
            log(
              '🆕 Received new_conversation payload (unknown shape): ' +
                JSON.stringify(payload),
            );
          }
        });

        socket.on('private:new_message', (message) => {
          log(
            '📩 New message received (id=' +
              message.id +
              ', conv=' +
              (message.conversationId || 'N/A') +
              ')',
          );
          const convId = message.conversationId;
          if (!convId) {
            log(
              '⚠️ Message without conversationId received: ' +
                JSON.stringify(message),
            );
            return;
          }
          pushMessageToStore(convId, message);
          // If the opened conversation is this one -> render messages
          if (currentConversationId === convId) {
            renderMessagesForCurrentConversation();
          } else {
            // mark unread visually in conversation list (simple log action)
            log('🔔 New message for other conversation: ' + convId);
          }
        });
      }

      // Load all conversations (short list with last message)
      function loadConversations() {
        if (!socket || !socket.connected) {
          log('⚠️ Not connected');
          return;
        }
        socket.emit('private:load_conversations');
        log('📤 Requested conversation list');
      }

      // Load single conversation (full history) by conversationId
      function openConversation(conversationId) {
        if (!socket || !socket.connected) {
          log('⚠️ Not connected');
          return;
        }
        if (!conversationId) {
          alert('conversationId required');
          return;
        }
        log('📤 Requesting conversation history for: ' + conversationId);
        socket.emit('private:load_single_conversation', conversationId);
      }

      // Convenience: find or create conversation by sending a message
      function sendMessage() {
        if (!socket || !socket.connected) {
          log('⚠️ Not connected');
          return;
        }
        if (!currentUserId) {
          alert('Not authenticated yet. Wait for private:success.');
          return;
        }

        const recipientIdInput = document
          .getElementById('recipientId')
          .value.trim();
        const messageText = document.getElementById('message').value.trim();

        // Prefer recipient from opened conversation participant if none provided
        let recipientId = recipientIdInput;
        if (!recipientId && currentConversationId) {
          const conv = conversationsById[currentConversationId];
          if (conv && conv.participant && conv.participant.id) {
            recipientId = conv.participant.id;
          }
        }

        if (!recipientId) {
          alert('Recipient ID required (or open a conversation)');
          return;
        }
        if (!messageText) {
          alert('Message text required');
          return;
        }

        const payload = {
          userId: currentUserId, // MUST match token sub
          recipientId,
          dto: { content: messageText },
          file: null,
        };

        socket.emit('private:send_message', payload);
        log('📤 Sent message:\n' + JSON.stringify(payload, null, 2));
        // optimistic UI: append locally with a temp id if conversation open
        // But we'll rely on private:new_message event from server to confirm / provide real id
        document.getElementById('message').value = '';
      }
    </script>
  </body>
</html>

```

---

# Quick checklist

- [ ]  Connect to `/js/private` with `auth.token = "Bearer <JWT>"`
- [ ]  Listen for `private:success` → store returned `userId`.
- [ ]  Emit `private:load_conversations` → handle `private:conversation_list`.
- [ ]  To send message, emit `private:send_message` with `{ userId: <from private:success>, recipientId, dto: { content } , file: null }`.
- [ ]  Listen for `private:new_message` → replace optimistic messages, dedupe by `id`.
- [ ]  Handle `private:error` globally.