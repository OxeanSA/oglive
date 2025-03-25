{% for stry in data %}
  <div class='stry-cnt-inl'>
    <div class='stry-container'>
      <div class="gradient-bg">
        <div class="u-media-cnt">
          {% if stry['story_type'] == "video" %}
            <video class="story-u-media" muted autoplay loop onload="onVidLoad(this, this.getAttribute('data-post-id'), false)" onclick="iurl('storyview', {sid: this.getAttribute('data-story-id') })" data-story-id="{{ stry['story_id'] }}" src="http://{{ _ipaddr }}:8000/video?uuid={{ stry['uid'] }}&ppic={{ stry['story_ul'] }}&ptp=story"></video>
          {% else %}
            <img class="story-u-media" onload="onImgLoad(this, this.getAttribute('data-src'))" src='assets/imgthumb.gif' onclick="iurl('storyview', {sid: this.getAttribute('data-story-id') })" data-story-id="{{ stry['story_id'] }}" data-src="http://{{ _ipaddr }}:8000/image?uuid={{ stry['uid'] }}&ppic={{ stry['story_ul'] }}&ptp=story">
          {% endif %}
        </div>
      </div>
      <!-- | replace(stry["username"], _tags("@(\w+)", stry["username"]) | safe) -->
      <div class="stry-uname">{{ helpers._trim(stry["username"], 7) | replace("_", ".") | replace("@", "") }}</div>
    </div>
  </div>
{% endfor %}