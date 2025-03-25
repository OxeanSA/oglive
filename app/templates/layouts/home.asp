<!-- FINAL LAYOUT. EDIT AS INDICATED! -->

{% block content %}
{% set profile = data['profile'] %}
  <div class="home-page">
    <div class="stories">
      <div class='stry-cnt-inl'>
        <div class='stry-container'>
          <div class="gradient-bg">
            <div class="u-media-cnt">
              <img class="m-u-media" onload="onImgLoad(this, this.getAttribute('data-src'))" onclick="eurl('upload', this)" data-src="assets/default.jpg" src="assets/default.jpg">
            </div>
          </div>
          <div class="stry-uname">Your Story</div>
        </div>
      </div>
       <div class='stry-cnt-inl'>
         <div id="strys">
           <div class='stry-cnt-inl'>
              <div class='stry-container'>
                <div class="ph-avatar avatar-big"></div>
                <div class="stry-uname"><i class="loader_dot">.</i><i class="loader_dot">.</i><i class="loader_dot">.</i></div>
              </div>
            </div>
            <div class='stry-cnt-inl'>
              <div class='stry-container'>
                <div class="ph-avatar avatar-big"></div>
                <div class="stry-uname"><i class="loader_dot">.</i><i class="loader_dot">.</i><i class="loader_dot">.</i></div>
              </div>
            </div>
            <div class='stry-cnt-inl'>
              <div class='stry-container'>
                <div class="ph-avatar avatar-big"></div>
                <div class="stry-uname"><i class="loader_dot">.</i><i class="loader_dot">.</i><i class="loader_dot">.</i></div>
              </div>
            </div>
            <div class='stry-cnt-inl'>
              <div class='stry-container'>
                <div class="ph-avatar avatar-big"></div>
                <div class="stry-uname"><i class="loader_dot">.</i><i class="loader_dot">.</i><i class="loader_dot">.</i></div>
              </div>
            </div>
            <div class='stry-cnt-inl'>
              <div class='stry-container'>
                <div class="ph-avatar avatar-big"></div>
                <div class="stry-uname"><i class="loader_dot">.</i><i class="loader_dot">.</i><i class="loader_dot">.</i></div>
              </div>
            </div>
            <div class='stry-cnt-inl'>
              <div class='stry-container'>
                <div class="ph-avatar avatar-big"></div>
                <div class="stry-uname"><i class="loader_dot">.</i><i class="loader_dot">.</i><i class="loader_dot">.</i></div>
              </div>
            </div>
            <div class='stry-cnt-inl'>
              <div class='stry-container'>
                <div class="ph-avatar avatar-big"></div>
                <div class="stry-uname"><i class="loader_dot">.</i><i class="loader_dot">.</i><i class="loader_dot">.</i></div>
              </div>
            </div>
       </div>
    </div>
    </div>
    <div class="home-search-container mt-8 mb-12">
      <div class="home-search-ics-container">
        <div class="search-icon-container">
          <div class="ai-icon"><i class="fa fa-circle-thin"></i></div>
        </div>
        <input type="search" aria-valuemin="2" autocomplete="off" name="search" class="home-search-input" placeholder="Ask or Search anything">
      </div>
      <div class="home-posts-filters-container">
        <div class="home-posts-filter-button videosfilter-button onclick-blue button fa fa-play-circle-o" onclick="videoPostsFilter('home')"></div>
        <div class="home-posts-filter-button market-button onclick-blue button fa fa-cart-arrow-down" onclick="marketPosts('home')"></div>
      </div>
    </div>

    <!-- EDIT: ADD ANIMATION CLASSES AND ONCLICK ACTIONS -->
    <div class="ics-home-inline mb-6">
      <div class="ai-search-cnt">
        <div class="ai-search-icr button active"></div>
        <span>For You</span>
      </div>
      <div class="ai-search-cnt">
        <div class="ai-search-icr button"></div>
        <span>Live</span>
      </div>
    </div>
    <!-- ... -->

    <div class="cc2nt" id="c140">
      <div class="c230"><i class="loader_dot">•</i><i class="loader_dot">•</i><i class="loader_dot">•</i></div>
    </div>
    <div class='mb-12'></div>
    <div class="posts" id="posts">
    </div>
  </div>
{% endblock %}