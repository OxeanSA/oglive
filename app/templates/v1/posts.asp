<!-- FINAL LAYOUT. EDIT AS INDICATED! -->

 <!-- TODO: CREATE TOP BREADCRUMB FOR POSTS FILTER -->
{% if "videos" in var %}
   <div class="pg-n">Videos</div>
{% elif 'market' in var %}
   <div class="pg-n">Market</div>
{% endif %}
{% for post in data %}
{% set likes = conn.execute("SELECT * FROM likes LEFT JOIN users ON users.user_id=likes.uid WHERE post_id=='{}'".format(post['post_id'])).fetchall() %}
{% set comments = conn.execute("SELECT * FROM comments LEFT JOIN users ON users.user_id=comments.uid WHERE post_id=='{}'".format(post['post_id'])).fetchall() %}
{% set forwards = conn.execute("SELECT * FROM forwards LEFT JOIN users ON users.user_id=forwards.uid WHERE post_id=='{}'".format(post['post_id'])).fetchall() %}
{% set username = post['firstname'] + ' ' + post['lastname'] %}
{% set usern = post['username'] %}
{% set post_text = post['post_text'] | replace(helpers._tags("(#\w+)", post['post_text']), "<span class='tagged-user'>{}</span>".format( helpers._tags("(#\w+)", post['post_text'])) | safe) %}
{% set post_text = post_text | replace(helpers._tags("(@\w+)", post_text), "<span class='tagged-user'>{}</span>".format( helpers._tags("@(\w+)", post_text)) | safe) %}
<div id="mu-post" data-postid="{{ post['post_id'] }}" class="mu-post mt-6">
   <div class="u-dtl">
      {% if post['profile'] == 'df' %}
         <div class="u-media-cnt">
            <img class="post-u-media u-media-avlc" src='assets/default.jpg'>
         </div>
      {% else %}
         <div class="u-media-cnt" onclick="iurl('profileview', {uuid: this.getAttribute('data-uuid') })" data-uuid="{{ post['user_id'] }}">
            <img onload="onImgLoad(this, this.getAttribute('data-src'))" src='assets/imgthumb.gif' class="post-u-media u-media-avl"  data-src="http://{{ _ipaddr }}:8000/image?uuid={{ post['user_id'] }}&ppic={{ post['profile'] }}&ptp=profile">
         </div>
      {% endif %}
      <div onclick="showMenu('home-post-image', {postid: this.getAttribute('data-postid'), username: this.getAttribute('data-username')})" data-postid="{{ post['post_id'] }}" data-username="{{ post['username'] }}" class="onclick-blue" id="post-drpbtn">•••</div>
      <div onclick="iurl('profileview', {uuid: this.getAttribute('data-uuid') })" data-uuid="{{ post['user_id'] }}" class="username onclick-blue">{{ username | replace(" ", " ") | replace("@", "") }}{% if post['ctype'] != 'ucf' %} <i class="fa fa-check-circle"></i>{% endif %}</div>
      {% if post['priority'] == 'public' %}
         <h3 class="p-date">
            <div class="p-date-ago">{{ helpers._time(post['date']) }}</div>
            <div class="dot"> • </div>
            <div class="icn"><i class="fa fa-globe"></i></div>
            {% if post['mtag'] != None %}
               <div class="atu"><font color="#e5e5e5"><div class="dot"> • </div></font>{{ post['mtag'] }}</div>
            {% endif %}
         </h3>
         {% elif post['priority'] == 'ad' %}
            <h3 class="p-date">Sponsored <div class='dot'>•</div> ad</h3>
         {% elif post['priority'] == 'private' %}
            <h3 class="p-date">Sponsored <div class='dot'>•</div> <i class='fa fa-lock'></i></h3>
         {% endif %}
   </div>
   <div class="mb-4"></div>
   <div class="post-inner">
      {% if post['post_type'] == 'image' %}
         <div class="text-container">
            <div class="p-text">{{ post_text }}</div>
         </div>
         <div class="p-media-cnt">
            <img id="p-media" onload="onImgLoad(this, this.getAttribute('data-src'))" onclick="iurl('postview', {pid: this.getAttribute('data-pid') })" data-pid="{{ post['post_id'] }}" src='assets/imgthumb.gif' data-src="http://{{ _ipaddr }}:8000/image?uuid={{ post['user_id'] }}&ppic={{ post['post_ul'] }}&ptp=post" class="p-media preview">
            <div class="post-media-caption" onclick="toggleMore(this, false)">
               <span class="post-media-caption-special-tag">{{ post['username'] }}</span>
               <div class="post-media-caption-loader"><i class="loader_dot">•</i></div>
            </div>
         </div>

         <!-- TODO: ADD AUTO TAGS -->
         <div class="left-vertical-container">
            {% if helpers._tags("(#\w+)", post['post_text']) != None %}
            <div class="test-left-vertical">•</div>
            <div class="text-test-left"><i>{{ helpers._tags("(#\w+)", post['post_text']) | safe }}</i></div>
            {% endif %}
            <div class="test-left-vertical">•</div>
            <div class="text-test-left"><i>oxean-d.</i></div>
            <div class="test-left-vertical">•</div>
            <div class="text-test-left"><i>f4yupg</i></div>
            <div class="test-left-vertical">•</div>
            <div class="text-test-left"><i>webtick</i></div>
         </div>
         <!-- ... -->

         <!-- TODO: CUSTOMIZE VIDEO PLAYER -->
      {% elif post['post_type'] == 'video' %}
         <div class="text-container">
            <div class="p-text">{{ post_text }}</div>
         </div>
         <div class="p-media-cnt">
            <video class="p-media" muted autoplay loop poster='assets/imgthumb.gif' preload="metadata" onclick="iurl('postview', {pid: this.getAttribute('data-post-id') })" data-post-id="{{ post['post_id'] }}" src="http://{{ _ipaddr }}:8000/video?uuid={{ post['user_id'] }}&ppic={{ post['post_ul'] }}&ptp=post"></video>
            <div class="post-media-mute mute-button fa fa-volume-mute" onclick="toggleMute(this, false)"></div>
            <div class="post-media-caption" onclick="toggleMore(this, false)">
               <span class="post-media-caption-special-tag">00:32 | {{ post['username'] }}</span>
               <div class="post-media-caption-loader"><i class="loader_dot">•</i></div>
            </div>
         </div>
         <!-- ... -->

         <!-- TODO: ADD AUTO TAGS -->
         <div class="left-vertical-container">
            <div class="test-left-vertical">•</div>
            <div class="text-test-left"><i>oxean-d.</i></div>
            <div class="test-left-vertical">•</div>
            <div class="text-test-left"><i>asher</i></div>
            <div class="test-left-vertical">•</div>
            <div class="text-test-left"><i>f4yupg</i></div>
            <div class="test-left-vertical">•</div>
            <div class="text-test-left"><i>webtick</i></div>
         </div>
         <!-- ... -->

      {% else %}]
           <img id="p-media" onload="onImgLoad(this, this.getAttribute('data-src'))" onclick="iurl('imgpreview', {pid: this.getAttribute('data-pid') })" data-pid="{{ post['post_id'] }}" src='assets/imgthumb.gif' data-src="http://{{ _ipaddr }}:8000/image?uuid={{ post['user_id'] }}&ppic={{ post['post_ul'] }}&ptp=post" class="p-media preview">
      {% endif %}
      <div class="bottom-pst-ics clear">
         <div class="post-bottom-container">
            <input type="text" placeholder="Add a comment" onclick="iurl('postview', {pid: this.getAttribute('data-pid') })" data-pid="{{ post['post_id'] }}" class="comment-ipt" readonly>
            <div class="items-ge-cover onclick-blue button-effect-a" onclick="addlike(this, this.getAttribute('data-pid'))" data-pid="{{ post['post_id'] }}"><i class="like-icon far fa-thumbs-o-up"></i> <span class="likes-count">{{ likes|length }}</span> &triangledown;</div>
            {% if comments|length > 0 %}
               <div class="ics-bottom-item-ge onclick-blue button-effect-a"><i class="comments-icon fa fa-comments-o"></i> {{ comments|length }}</div>
            {% endif %}
            {% if forwards|length > 0 %}
               <div class="ics-bottom-item-ge onclick-blue button-effect-a" onclick="sharePost(this, this.getAttribute('data-pid'))" data-pid="{{ post['post_id'] }}"><i class="share-icon fa fa-share"></i> {{ forwards|length }}</div>
            {% endif %}
         </div>
      </div>
   </div>
</div>
{% endfor %}

<!--
<div class="recommended-content">
   <div class="section-title">For you</div>
   <div class="suggested-users-inline mt-8">
      {% for fn in f %}
      <div class='suggested-users-inline-cnt-inl'>
         <div class='suggested-users-inline-container'>
            <div class="avatar">
               {% if fn['profile'] == 'df' %}
                 <img src='assets/default.jpg'>
               {% else %}
                <img src="http://{{ _ipaddr }}:8000/image?uuid={{ fn['id'] }}&ppic={{ fn['profile'] }}&ptp=profile">
               {% endif %}
            </div>
            {% set uname = fn['firstname'] + " " + fn['lastname'] %}
            <div class="suggested-users-inline-uname">{{ helpers._trim(uname, 7) | replace("_", ".") | replace("@", "") }}</div>
            <span class="suggested-bottom-count"><i class="fa fa-users"></i></i> {{ _rand(3, "digits") }}</span>
            <div class="suggested-users-follow-button mt-6">Follow</div>
         </div>
      </div>
      {% endfor %}
   </div>
</div>
<div class="c230"><i class="loader_dot">•</i><i class="loader_dot">•</i><i class="loader_dot">•</i></div>
-->
