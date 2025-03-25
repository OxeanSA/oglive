{% set profile = conn.execute("SELECT profile FROM users WHERE user_id=='{}'".format(data)).fetchone()['profile'] %}
{% set acctype = conn.execute("SELECT ctype FROM users WHERE user_id=='{}'".format(data)).fetchone()['ctype'] %}
{% set prfl = conn.execute("SELECT firstname, lastname FROM users WHERE user_id=='{}'".format(data)).fetchone() %}
{% set _username = prfl['firstname'] + ' ' + prfl['lastname'] %}
<div class="chat">
    <div class="contact bar">
      <div class="bar-btn-gr"><svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-grid" viewBox="0 0 16 16"> <path d="M1 2.5A1.5 1.5 0 0 1 2.5 1h3A1.5 1.5 0 0 1 7 2.5v3A1.5 1.5 0 0 1 5.5 7h-3A1.5 1.5 0 0 1 1 5.5v-3zM2.5 2a.5.5 0 0 0-.5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 0-.5-.5h-3zm6.5.5A1.5 1.5 0 0 1 10.5 1h3A1.5 1.5 0 0 1 15 2.5v3A1.5 1.5 0 0 1 13.5 7h-3A1.5 1.5 0 0 1 9 5.5v-3zm1.5-.5a.5.5 0 0 0-.5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 0-.5-.5h-3zM1 10.5A1.5 1.5 0 0 1 2.5 9h3A1.5 1.5 0 0 1 7 10.5v3A1.5 1.5 0 0 1 5.5 15h-3A1.5 1.5 0 0 1 1 13.5v-3zm1.5-.5a.5.5 0 0 0-.5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 0-.5-.5h-3zm6.5.5A1.5 1.5 0 0 1 10.5 9h3a1.5 1.5 0 0 1 1.5 1.5v3a1.5 1.5 0 0 1-1.5 1.5h-3A1.5 1.5 0 0 1 9 13.5v-3zm1.5-.5a.5.5 0 0 0-.5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 0-.5-.5h-3z"/> </svg></div>
      <div class="bar-btn-gr"><svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-camera-video" viewBox="0 0 16 16"> <path fill-rule="evenodd" d="M0 5a2 2 0 0 1 2-2h7.5a2 2 0 0 1 1.983 1.738l3.11-1.382A1 1 0 0 1 16 4.269v7.462a1 1 0 0 1-1.406.913l-3.111-1.382A2 2 0 0 1 9.5 13H2a2 2 0 0 1-2-2V5zm11.5 5.175 3.5 1.556V4.269l-3.5 1.556v4.35zM2 4a1 1 0 0 0-1 1v6a1 1 0 0 0 1 1h7.5a1 1 0 0 0 1-1V5a1 1 0 0 0-1-1H2z"/> </svg></div>
      <div class="bar-btn-gr"><svg xmlns="http://www.w3.org/2000/svg" width="17" height="17" fill="currentColor" class="bi bi-telephone" viewBox="0 0 16 16"> <path d="M3.654 1.328a.678.678 0 0 0-1.015-.063L1.605 2.3c-.483.484-.661 1.169-.45 1.77a17.568 17.568 0 0 0 4.168 6.608 17.569 17.569 0 0 0 6.608 4.168c.601.211 1.286.033 1.77-.45l1.034-1.034a.678.678 0 0 0-.063-1.015l-2.307-1.794a.678.678 0 0 0-.58-.122l-2.19.547a1.745 1.745 0 0 1-1.657-.459L5.482 8.062a1.745 1.745 0 0 1-.46-1.657l.548-2.19a.678.678 0 0 0-.122-.58L3.654 1.328zM1.884.511a1.745 1.745 0 0 1 2.612.163L6.29 2.98c.329.423.445.974.315 1.494l-.547 2.19a.678.678 0 0 0 .178.643l2.457 2.457a.678.678 0 0 0 .644.178l2.189-.547a1.745 1.745 0 0 1 1.494.315l2.306 1.794c.829.645.905 1.87.163 2.611l-1.034 1.034c-.74.74-1.846 1.065-2.877.702a18.634 18.634 0 0 1-7.01-4.42 18.634 18.634 0 0 1-4.42-7.009c-.362-1.03-.037-2.137.703-2.877L1.885.511z"/> </svg>
      </div>
      <div class="bar-btn-gl onclick-blue" onclick="BackTo('home', 'useCache')">
        <svg xmlns="http://www.w3.org/2000/svg" height="28" viewBox="0 -960 960 960" width="29">
          <path d="M560-240 320-480l240-240 56 56-184 184 184 184-56 56Z"/>
        </svg>
      </div>
      <div class="chat-user-detail">
        {% if profile == 'df' %}
          <img class="cu-media" onclick="iurl('vprofile', {uuid: this.getAttribute('data-uuid') })" data-uuid="{{ uid }}" src='assets/default.jpg'>
        {% else %}
          <img class="cu-media" onclick="iurl('vprofile', {uuid: this.getAttribute('data-uuid') })" data-uuid="{{ uuid }}" src='http://{{ _ipaddr }}:8000/image?uuid={{ data }}&ppic={{ profile }}&ptp=profile'>
        {% endif %}
      </div>
      <div class="chat-username">
        {{ _username | replace(" ", " ") }}{% if acctype != 'ucf' %} <i class="fa fa-check-circle"></i> {% endif %}
      </div>
      <div class="last-seen typing">12:56</div>
      
    </div>
    <div class="timeline-container">
      <div class="time">Today</div>
    </div>
    <div class="messages mt-100" id="chat"></div>
    <div class="mt-50"></div>
    <div class="input">
      <div class="input-camera fa fa-face-smile"></div>
      <div class="message-input-container">
        <input placeholder="Type a message" class="message-input" type="text">
      </div>
      <div class="voice-input fa fa-microphone"></div>
      <div class="input-attachments fa fa-paperclip"></div>
      <div class="input-send-button fa fa-paper-plane" onclick="sendMessage(this.getAttribute('data-uuid'))" data-uuid="{{ data }}"></div>
    </div>
  </div>
</div>