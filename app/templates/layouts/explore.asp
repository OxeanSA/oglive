{% block content %}
   {% set profile = conn.execute("SELECT profile FROM users WHERE user_id=='{}'".format(id)).fetchone()['profile'] %}
   <div class="pg-n">Explore •</div>
   <div class="ics-home-inline mb-6">
      <div class="search-ai-cnt">
         <div class="fa ai-search-icon fa-circle-thin"></div>
       </div>
      <div class="ai-search-cnt">
        <div class="ai-search-icr active"></div>
        <span>Popular</span>
      </div>
      <div class="ai-search-cnt">
        <div class="ai-search-icr"></div>
        <span>Live</span>
      </div>
      <div class="ai-search-cnt">
         <div class="ai-search-icr"></div>
         <span>Reels</span>
      </div>
   </div>
   <div class='mb-20'></div>
   <div class="cc2nt" id="c140">
      <div class="c230"><i class="loader_dot">•</i><i class="loader_dot">•</i><i class="loader_dot">•</i></div>
   </div>
   <div class="posts" id="posts"></div>
{% endblock %}