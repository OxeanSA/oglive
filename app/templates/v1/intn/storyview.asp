<div class="story-preview">
    <div class="story-preview-header-top">
          <div class="bar-btn-gl onclick-blue" onclick="BackTo('home', 'useCache')">
              <svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" height="28" viewBox="0 -960 960 960" width="29">
                  <path d="M560-240 320-480l240-240 56 56-184 184 184 184-56 56Z"/>
              </svg>
          </div>
          <div class="story-preview-items-detail">
            {% if data.profile == 'df' %}
              <img class="story-preview-user-media-top" src='assets/default.jpg'>
          {% else %}
              <img class="story-preview-user-media-top" src="http://{{ _ipaddr }}:8000/image?uuid={{ data.uid }}&ppic={{ data.profile }}&ptp=profile">
          {% endif %}
              <div class="username">{{ data.username }}</div>
          </div>
    </div>
    
    <div class="story-preview-items">
      {% if data.story_type == "image" %}
        <div class="story-preview-items-media-container">
            <div class="story-preview-media-container">
                <img class="story-preview-items-media" src="http://{{ _ipaddr }}:8000/image?uuid={{ data.uid }}&ppic={{ data.story_ul }}&ptp=story">
                <!-- EDIT: ADD AUTO TAGS 
                <div class="story-preview-tags">
                  <div class="story-preview-tags-left"><i>#digital_hub</i></div>
                  <div class="story-preview-test-left-vertical">•</div>
                  <div class="story-preview-tags-left"><i>asher42</i></div>
                  <div class="story-preview-test-left-vertical">•</div>
                  <div class="story-preview-tags-left"><i>#botstown</i></div>
                  <div class="story-preview-test-left-vertical">•</div>
                  <div class="story-preview-tags-left"><i>webtick</i></div>
                  <div class="story-preview-test-left-vertical">•</div>
                </div>
                -->
                <div class="story-preview-media-caption" onclick="toggleMore(this, false)">
                    <div class="story-preview-media-caption-special-tag">{{ data.username }} | @oxeanvibes</div>
                </div>
                <div class="story-preview-media-side-buttons" onclick="toggleMute(this, false)">
                    <div class="story-preview-media-side-icon fa fa-share"></div>
                    <div>1k</div>
                    
                    <div class="story-preview-media-side-icon fa fa-comments-o"></div>
                    <div>1k</div>
                    
                    <div class="story-preview-media-side-icon far fa-thumbs-o-up"></div>
                    <div>1k</div>
                </div>
            </div>

          <div class="story-preview-btn-gr onclick-blue">•••</div>
        </div>
        {% elif data.story_type == "video" %}
              <div class="story-preview-items-media-container">
                  <video class="story-preview-items-media" muted autoplay loop onload="onVidLoad(this, this.getAttribute('data-story-id'), true)" data-story-id="{{ data.story_id }}" src="http://{{ _ipaddr }}:8000/video?uuid={{ data.uid }}&ppic={{ data.story_ul }}&ptp=story"></video>
                  <!--EDIT: ADD JAVASCRIPT EVENTS -->
                  <div class="player-actions">
                      <div class="media-button fa fa-play" hidden id="play"></div>
                      <div class="media-button fa fa-pause" id="pause"></div>
                  </div>
                  <div class="player-progress">
                      <input class="progress" id="progress" type="range" min="0" value="0" step=".1">
                  </div>
                  <div class="player-actions-bottom">
                      <div class="player-volume-button"><i class="fa fa-volume-mute"></i></div>
                      <div class="player-fullscreen-button"><i class="fa fa-expand"></i></div>
                      <div class="player-time-progress-left">00:00</div>
                      <div class="player-time-progress-right">02:00</div>
                  </div>
                  <!-- ... -->

                  <!-- EDIT: ADD AUTO TAGS 
                  <div class="story-preview-tags">
                      <div class="story-preview-tags-left"><i>#digital_hub</i></div>
                      <div class="story-preview-test-left-vertical">•</div>
                      <div class="story-preview-tags-left"><i>asher42</i></div>
                      <div class="story-preview-test-left-vertical">•</div>
                      <div class="story-preview-tags-left"><i>#botstown</i></div>
                      <div class="story-preview-test-left-vertical">•</div>
                      <div class="story-preview-tags-left"><i>webtick</i></div>
                      <div class="story-preview-test-left-vertical">•</div>
                  </div>
                  ... -->

                  <div class="story-preview-btn-gr onclick-blue">•••</div>
              </div>
          {% else %}
              <div class="story-preview-items-media-container">
                  <img class="story-preview-items-media" src="assets/notavailablebig.jpg">
              </div>
          {% endif %}
      </div>
      <div class="bottom-pst-ics default-background">
        <img class="bottom-item-image" src="http://{{ _ipaddr }}:8000/image?uuid={{ logged_user_id }}&ppic={{ profile }}&ptp=profile">
        <input type="text" placeholder="Add a comment" onsubmit="iurl('vpost', {pid: this.getAttribute('data-pid') })" data-pid="{{ data['post_id'] }}" class="comment-input">
        <div class="ics-bottom-items">
            <div class="items-ge-cover" onclick="addlike(this, this.getAttribute('data-pid'))" data-pid="{{ data['post_id'] }}"><i class="like-icon far fa-thumbs-o-up"></i> <span class="likes-count">11</span> &triangledown;</div>
            
        </div>
    </div>
      
</div>
