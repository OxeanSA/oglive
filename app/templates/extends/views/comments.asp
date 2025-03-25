{% set profile = conn.execute("SELECT profile FROM users WHERE id=='{}'".format(id)).fetchone()['profile'] %}
{% for post in post %}
    {% set likes = conn.execute("SELECT * FROM likes LEFT JOIN users ON users.id=likes.uid WHERE post_id=='{}'".format(post['post_id'])).fetchall() %}
    {% set comments = conn.execute("SELECT * FROM comments LEFT JOIN users ON users.id=comments.uid WHERE post_id=='{}'".format(post['post_id'])).fetchall() %}
    {% set forwards = conn.execute("SELECT * FROM forwards LEFT JOIN users ON users.id=forwards.uid WHERE post_id=='{}'".format(post['post_id'])).fetchall() %}
    {% set username = post['firstname'] + ' ' + post['lastname'] %}
	  {% set usern = post['username'] %}
    {% set post_text = post['post_txt'] | replace(_tags("(#\w+)", post['post_txt']), "<font class='tagged-user'>{}</font>".format( _tags("(#\w+)", post['post_txt'])) | safe) %}
    {% set post_text = post_text | replace(_tags("(@\w+)", post_text), "<font class='tagged-user'>{}</font>".format( _tags("@(\w+)", post_text)) | safe) %}
    {% set post_pic = 'uploads/users/{}/posts/images/{}'.format(post['uid'], post['post_pic']) %}
    {% set post_profile = "uploads/users/{}/profiles/{}".format(post['uid'], post['profile']) %}
    {% set p_uprofile = "uploads/users/{}/profiles/{}".format(id, profile) %}
    {% set _path_i = url_for('static', filename='uploads/users/{}/posts/images/{}'.format(post['uid'], post['post_pic'])) %}
    {% set post_vid = url_for('static', filename='uploads/users/{}/posts/videos/{}'.format(post['uid'], post['post_vid'])) %}
    <div class="mt-4"></div>
    <div id="post-cm post-comment" data-postid="{{ post['post_id'] }}" class="post-cm post-comment">
      <div class="">
      <div class="u-dtl z-index-upper">
        <div class="profile-view-header-top">
          <div class="bar-btn-gl" onclick="BackTo('home', 'useCache')">
            <svg xmlns="http://www.w3.org/2000/svg" height="28" viewBox="0 -960 960 960" width="29">
              <path d="M560-240 320-480l240-240 56 56-184 184 184 184-56 56Z"/>
            </svg>
          </div>
          <div class="bar-btn-gl-text">Comments</div>
          <div class="bar-btn-gf"><i class="fas fa-comment"></i></div>
        </div>
        {% if post['profile'] == 'df' %}
            <img lazy="true" class="vpost-post-u-pic" src='assets/default.jpg'>
        {% else %}
            <img lazy="true" class="vpost-post-u-pic" src="http://{{ _ipaddr }}:8000/image?uuid={{ post['uid'] }}&ppic={{ post['profile'] }}&ptp=profile">
        {% endif %}
        <div class="post-dropdown">
          <div onclick="drpmenu()" id="post-drpbtn">•••</div>
        </div>
        <div class="username">{{ username | replace(" ", " ") }}</div>
         {% if post['priority'] == 'public' %}
            <div class="p-date"><div class="p-date-ago">{{ _time(post['date']) }}</div><div class="dot"> • </div><div class="icn"><i class="fa fa-globe"></i></div>
            {% if post['mtag'] != None %}
               <div class="atu"><font color="#e5e5e5"><div class="dot"> • </div></font>{{ post['mtag'] }}</div>
            {% endif %}
         {% elif post['priority'] == 'ad' %}
            <div class="p-date">Sponsored <div class='dot'>•</div> ad</div>
         {% elif post['priority'] == 'private' %}
            <div class="p-date">Sponsored <div class='dot'>•</div> <i class='fa fa-lock'></i></div>
         {% endif %}
      </div>
      <div class="bottom-pst-ics default-background">
        <img class="bottom-item-image" src="http://{{ _ipaddr }}:8000/image?uuid={{ id }}&ppic={{ profile }}&ptp=profile">
        <input type="text" placeholder="Add a comment" onsubmit="iurl('vpost', {pid: this.getAttribute('data-pid') })" data-pid="{{ post['post_id'] }}" class="comment-input">
        <div class="ics-bottom-items">
          <div class="items-ge-cover" onclick="addlike(this, this.getAttribute('data-pid'))" data-pid="{{ post['post_id'] }}"><i class="like-icon far fa-thumbs-o-up"></i> <span class="likes-count">{{ likes|length }}</span> &triangledown;</div>
               <div class="ics-bottom-item-ge"><i class="comments-icon fa fa-comments-o"></i> {{ comments|length }}</div>
               <div class="ics-bottom-item-ge" onclick="sharePost(this, this.getAttribute('data-pid'))" data-pid="{{ post['post_id'] }}"><i class="share-icon fa fa-share"></i> {{ forwards|length }}</div>
          </div>
        </div>
      </div>
      <div class="mt-30"></div>
      <div>
       {% if post['post_type'] == "image" %}
         <div class="p-pic-cnt">
          <img lazy="true" id="p-pic" onclick="iurl('viewpost', {pid: this.getAttribute('data-pid') })" data-pid="{{ post['post_id'] }}" src="http://{{ _ipaddr }}:8000/image?uuid={{ post['uid'] }}&ppic={{ post['post_pic'] }}&ptp=post" class="p-pic">
         </div>
       {% elif post['post_type'] == "video" %}
         <div class="p-text">{{ post_text }}</div>
         <div class="p-vid-cnt">
           <video class="p-vid" src="{{ url_for('video', path=post_vid|replace('/', 'cxit2')) }}"></video>
         </div>
       {% else %}
       <div class="p-text-bold">{{ post_text }}</div>
       {% endif %}
        
        <div class="p-text-bottom">{{ post_text }}</div>
      </div>
        <div class="clear section-title">Comments</div>
        <div class="z-index-lower">
          <div class="comments-user-comment">
            <div class="user-banner">
              <div class="user">
                <div class="avatar">
                  <img src="assets/default.jpg">
                  <span class="stat grey"></span>
                </div>
                <h5>Floyd Miles</h5>
              </div>
            </div>
            <div class="content">
              <div class="comment-content-text">Actually, now that I try out the links on my message, above, none of them take me to the secure site. Only my shortcut on my desktop, which I created years ago.</div>
            </div>
            <div class="footer">
              <button class="btn-react"><i class="ri-emotion-line"></i></button>
              
              <div class="divider"></div>
              <a href="#">Reply</a>
              <div class="divider"></div>
              <span class="is-mute">6 hour</span>
            </div>
          </div>
          <div>
            <div class="comments-user-comment">
              <div class="user-banner">
                <div class="user">
                  <div class="avatar" style="background-color:#fff5e9;border-color:#ffe0bd; color:#F98600">
                    AF
                    <span class="stat green"></span>
                  </div>
                  <h5>Albert Flores</h5>
                </div>
              </div>
              <div class="content">
                <div class="comment-content-text">Before installing this plugin please put back again your wordpress and site url back to http.</div>
              </div>
              <div class="footer">
                <div class="divider"></div>
                <a href="#">Reply</a>
                <div class="divider"></div>
                <span class="is-mute">2 min</span>
              </div>
            </div>
            <div class="reply comments-user-comment">
              <div class="user-banner">
                <div class="user">
                  <div class="avatar">
                    <img src="assets/default.jpg" alt="">
                    <span class="stat green"></span>
                  </div>
                  <h5>Bessie Cooper</h5>
                </div>
              </div>
              <div class="content">
                <div class="comment-content-text">Hi <font class="tagged-user">@Albert Flores</font>.Thanks for your reply.</div>
              </div>
              
            </div>
          </div>
          <div class="load">
            <span><i class="ri-refresh-line"></i>Loading</span>
          </div>
  
        </div>
        <div class="mb-40"></div>
        
      </div>
    </div>
{% endfor %}