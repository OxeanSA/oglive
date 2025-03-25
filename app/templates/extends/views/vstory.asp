{% for stry in stry %}
    <div class="story">
      <div class="contact bar top fixed mt-4">
        <div class="su-pic-container">
          {% if stry['profile'] == 'df' %}
            <img class="su-pic" onclick="iurl('vprofile', {uuid: this.getAttribute('data-uuid') })" data-uuid="{{ uid }}" src='assets/default.jpg'>
          {% else %}
            <img class="su-pic" onclick="iurl('vprofile', {uuid: this.getAttribute('data-uuid') })" data-uuid="{{ uuid }}" src="http://{{ _ipaddr }}:8000/image?uuid={{ stry['uid'] }}&ppic={{ stry['profile'] }}&ptp=profile">
          {% endif %}
        </div>
        <div class="_username">{{ stry['username'] | replace("_", ".") | replace("@", "") }}</div>
        <div class="_date">Today, 12:25</div>
        <div class="bar-btn-gr">•••</div>

      </div>
      <div class="story-container">
        <div class="story-items">
          <div class="story-items-img-container">
            {% if stry['story_pic'] == None %}
                <img class="story-u-pic" src="assets/imgthumb.gif">
            {% else %}
                <img class="story-items-img" src="http://{{ _ipaddr }}:8000/image?uuid={{ stry['uid'] }}&ppic={{ stry['story_pic'] }}&ptp=story">
            {% endif %}
          </div>
          <nav class="story-slide-nav">
            <div class="story-slide-thumb"></div> 
            
          </nav>  
        </div>
    </div>
    </div>
{% endfor %}