{% if settings.popup_temp and settings.popup_temp_title and settings.popup_temp_text%}
  <div id="popup-temp" class="popup-temp position-fixed d-flex flex-column align-items-end" style="bottom: 20px; right: 70px; z-index: 9999; opacity:0; transition: opacity 0.5s ease-in-out; margin-left: 10px;">
    <div class="popup-temp-content d-flex justify-content-between align-items-center bg-white" style="max-width: 700px;width: 100%;position: relative;background: white; border-radius: 10px 0 0 0;">
      
      {% if settings.popup_temp_emoji %}
        <div class="emoji" style="margin: auto 15px; font-size: xx-large;">{{ settings.popup_temp_emoji }}</div>
      {% endif %}
      
      <div class="popup-text flex-grow-1" {% if not settings.popup_temp_emoji %}style="padding-left:10px;"{% endif %}>
        <div class="mb-1" style="font-size: small; text-transform: uppercase; margin-right: 10px;"><strong>{{ settings.popup_temp_title }}</strong></div>
        <div style="font-size: small; margin-right: 10px;">{{ settings.popup_temp_text }}</div>
      </div>
      
      {% if settings.popup_temp_cta and settings.popup_temp_link %}
        <div class="popup-cta" style="background: #646464; display: flex; align-items: center; align-self: stretch;">
          <a style="padding: 20px 10px 20px 10px; font-size: smaller; color:white; text-align:center;" href="{{settings.popup_temp_link}}"><strong>{{ settings.popup_temp_cta }}</strong></a>
        </div>
      {% endif %}

      <button onclick="document.getElementById('popup-temp').remove()" class="btn-close position-absolute" style="top: -10px;right: -10px;height: 30px;width: 30px;border-radius: 100%;border: unset;">
        <svg class="icon-inline svg-icon-text"><use xlink:href="#times"></use></svg>
      </button>
    </div>

    {% if settings.popup_temp_data and settings.popup_temp_hora %}
      <div class="popup-timer bg-black text-white text-center w-100 py-2 fs-6" style="background: black; color: white; border-radius: 0 0 10px 10px; font-size: small;">
        Essas ofertas expiram em: <span id="popup-countdown">-- dias --:--:--</span>
      </div>
    {% endif %}

  </div>

  {% if settings.popup_temp_data and settings.popup_temp_hora %}
    <script>
      document.addEventListener("DOMContentLoaded", function () {
        const endDateStr = "{{ settings.popup_temp_data }} {{ settings.popup_temp_hora }}";
        const endDateParts = endDateStr.split(/[/ :]/);
        const countdownTarget = new Date(`20${endDateParts[2]}`, endDateParts[1] - 1, endDateParts[0], endDateParts[3], endDateParts[4]);
        const popup = document.getElementById("popup-temp");
        const countdownEl = document.getElementById("popup-countdown");

        function updateCountdown() {
          const now = new Date();
          const diff = countdownTarget - now;

          if (diff <= 0) {
            if (popup) popup.remove();
            return;
          }

          const days = Math.floor(diff / (1000 * 60 * 60 * 24));
          const hours = String(Math.floor((diff / (1000 * 60 * 60)) % 24)).padStart(2, '0');
          const minutes = String(Math.floor((diff / (1000 * 60)) % 60)).padStart(2, '0');
          const seconds = String(Math.floor((diff / 1000) % 60)).padStart(2, '0');

            if (days === 0) {
              countdownEl.textContent = `${hours}:${minutes}:${seconds}`;
            } else {
              const labelDias = days === 1 ? "dia" : "dias";
              countdownEl.textContent = `${days} ${labelDias} ${hours}:${minutes}:${seconds}`;
          }

          setTimeout(updateCountdown, 1000);
        }

        const now = new Date();
        const diff = countdownTarget - now;
        if (diff > 0) {
          setTimeout(() => {
            updateCountdown();
            if (popup) popup.style.opacity = "1";
          }, 3000);
        }
      });
    </script>
  {% endif %}
{% endif %}
