{% block content %}
<div class="messages-page">
  <div class="pg-n">Messages +</div>
  <div class='nav-b mb-12'>
    <div class='tag' id='active'>
      <div class='fa fa-lock'></div><span> Private</span>
   </div>
   <div class='tag tagt'>
      <div id='gtag' class='fa fa-users'></div><span> Business</span>
   </div>
  </div>
  <div class='actv mt-14' id="actv">
    <div class='actv-cnt-inl'>
      <div class='actv-container'>
        <div class="ph-avatar avatar-small"></div>
        <div class="actv-uname"><i class="loader_dot">.</i><i class="loader_dot">.</i><i class="loader_dot">.</i></div>
      </div>
    </div>
    <div class='actv-cnt-inl'>
      <div class='actv-container'>
        <div class="ph-avatar avatar-small"></div>
        <div class="actv-uname"><i class="loader_dot">.</i><i class="loader_dot">.</i><i class="loader_dot">.</i></div>
      </div>
    </div>
    <div class='actv-cnt-inl'>
      <div class='actv-container'>
        <div class="ph-avatar avatar-small"></div>
        <div class="actv-uname"><i class="loader_dot">.</i><i class="loader_dot">.</i><i class="loader_dot">.</i></div>
      </div>
    </div>
    <div class='actv-cnt-inl'>
      <div class='actv-container'>
        <div class="ph-avatar avatar-small"></div>
        <div class="actv-uname"><i class="loader_dot">.</i><i class="loader_dot">.</i><i class="loader_dot">.</i></div>
      </div>
    </div>
    <div class='actv-cnt-inl'>
      <div class='actv-container'>
        <div class="ph-avatar avatar-small"></div>
        <div class="actv-uname"><i class="loader_dot">.</i><i class="loader_dot">.</i><i class="loader_dot">.</i></div>
      </div>
    </div>
    <div class='actv-cnt-inl'>
      <div class='actv-container'>
        <div class="ph-avatar avatar-small"></div>
        <div class="actv-uname"><i class="loader_dot">.</i><i class="loader_dot">.</i><i class="loader_dot">.</i></div>
      </div>
    </div>
    <div class='actv-cnt-inl'>
      <div class='actv-container'>
        <div class="ph-avatar avatar-small"></div>
        <div class="actv-uname"><i class="loader_dot">.</i><i class="loader_dot">.</i><i class="loader_dot">.</i></div>
      </div>
    </div>
  </div>
  <div class="messages-search-container mt-4 mb-12">
    <div class="messages-search-ics-container">
      <div class="search-ics-c">
        <div class="ai-icon"><i class="fa fa-circle-thin"></i></div>
      </div>
      <input type="search" aria-valuemin="1" autocomplete="none" name="search" class="messages-search-input" placeholder="Search messages">
    </div>
    <div class="icn ics-right-ge onclick-blue fa fa-add"></div>
    <div class="icn history-button fa fa-gear onclick-blue"></div>
  </div>
  <!-- EDIT: ADD ANIMATION CLASSES AND ONCLICK ACTIONS -->
  <div class="ics-home-inline mb-6">
    <div class="ai-search-cnt">
      <div class="ai-search-icr active"></div>
      <span>All (3)</span>
    </div>
    <div class="ai-search-cnt">
      <div class="ai-search-icr"></div>
      <span>Unread</span>
    </div>
    <div class="ai-search-cnt">
      <div class="ai-search-icr"></div>
      <span>Groups</span>
    </div>
  </div>
  <!-- ... -->
  <div class="cc2nt" id="c140">
    <div class="c230"><i class="loader_dot">•</i><i class="loader_dot">•</i><i class="loader_dot">•</i></div>
  </div>
  <div id='msgs' class="mt-14"></div>
</div>
{% endblock %}