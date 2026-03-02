{% set spanish_gallery = settings.institutionalSpanishGallery %}
{% set has_spanish_gallery = spanish_gallery and spanish_gallery is not empty %}
{% set spanish_gallery_slides_count = has_spanish_gallery ? spanish_gallery | length : 3 %}
{% set has_admin_about_image = "institutional_spanish_about.jpg" | has_custom_image %}

<style>
    .english-page {
        --english-ink: #1f1a17;
        --english-muted: #6f675f;
        --english-line: #cdc1b1;
        --english-accent: #7b8d66;
        --english-accent-soft: #e3ead8;
        --english-sand: #f6f0e6;
        --english-white: #fffdf9;
        color: var(--english-ink);
        padding: 2.5rem 0 4.5rem;
    }

    .english-page__notice {
        font-size: 0.95rem;
        font-weight: 600;
        letter-spacing: 0.08em;
        text-align: center;
        text-transform: uppercase;
    }

    .english-page__hero {
        margin-bottom: 10px;
    }

    .english-page__slider-content {
        position: relative;
    }

    .english-page__slider-carousel {
        overflow: hidden;
    }

    .english-page__slider-track {
        align-items: stretch;
    }

    .english-page__slide {
        height: auto;
    }

    .english-page__slide-link {
        display: block;
        height: 100%;
    }

    .english-page__slide-media {
        aspect-ratio: 2 / 3;
        background: #d7d2c8;
        overflow: hidden;
    }

    .english-page__slide img,
    .english-page__slide-placeholder {
        width: 100%;
        height: 100%;
        display: block;
    }

    .english-page__slide img {
        object-fit: cover;
    }

    .english-page__slide-placeholder {
        align-items: flex-end;
        background:
            linear-gradient(180deg, rgba(16, 16, 16, 0.1) 0%, rgba(16, 16, 16, 0.5) 100%),
            linear-gradient(135deg, #cbbba5 0%, #7b8d66 100%);
        display: flex;
        padding: 2rem;
    }

    .english-page__slide:nth-child(2) .english-page__slide-placeholder {
        background:
            linear-gradient(180deg, rgba(16, 16, 16, 0.1) 0%, rgba(16, 16, 16, 0.5) 100%),
            linear-gradient(135deg, #d7c7b5 0%, #a97d58 100%);
    }

    .english-page__slide:nth-child(3) .english-page__slide-placeholder {
        background:
            linear-gradient(180deg, rgba(16, 16, 16, 0.1) 0%, rgba(16, 16, 16, 0.5) 100%),
            linear-gradient(135deg, #c1cfb3 0%, #6a6a52 100%);
    }

    .english-page__slide-caption {
        color: #ffffff;
        max-width: 24rem;
    }

    .english-page__slide-caption span {
        display: block;
        font-size: 0.82rem;
        font-weight: 600;
        letter-spacing: 0.16em;
        margin-bottom: 0.65rem;
        text-transform: uppercase;
    }

    .english-page__slide-caption strong {
        display: block;
        font-size: clamp(1.8rem, 3vw, 3.1rem);
        line-height: 1.05;
    }

    .english-page__slider-shell .svg-icon-text {
        fill: var(--english-ink);
    }

    .english-page__slider-shell .swiper-button-prev,
    .english-page__slider-shell .swiper-button-next {
        color: var(--english-ink);
    }

    .english-page__slider-shell .swiper-pagination {
        position: relative;
        margin-top: 1rem;
    }

    .english-page__slider-shell .swiper-pagination-bullet {
        border-color: var(--english-ink);
        background: transparent;
    }

    .english-page__slider-shell .swiper-pagination-bullet-active {
        background: var(--english-ink);
    }

    .english-page__section {
        margin-bottom: 10px;
    }

    .english-page__section--fairs {
        --english-section-bg: #f4f7ef;
    }

    .english-page__section--contact {
        --english-section-bg: #f8f5ef;
    }

    .english-page__section-title {
        align-items: center;
        display: flex;
        gap: 1rem;
        justify-content: center;
        margin-bottom: 2.25rem;
        text-align: center;
    }

    .english-page__section-title::before,
    .english-page__section-title::after {
        border-top: 1px solid var(--english-line);
        content: "";
        flex: 1 1 auto;
    }

    .english-page__section-title span {
        display: inline-block;
        font-size: clamp(1.35rem, 2vw, 1.8rem);
        font-weight: 700;
        letter-spacing: 0.18em;
        padding: 0 1rem;
        text-transform: uppercase;
    }

    .english-page__text-card,
    .english-page__photo-frame,
    .english-page__contact-card {
        background: rgba(255, 255, 255, 0.72);
        border: 1px solid rgba(31, 26, 23, 0.1);
        box-shadow: 0 18px 38px rgba(31, 26, 23, 0.06);
        height: 100%;
        padding: 1.75rem;
    }

    .english-page__photo-frame {
        border: 2px solid #111111;
        padding: 5px;
    }

    .english-page__photo-frame img,
    .english-page__photo-placeholder {
        display: block;
        min-height: 100%;
        width: 100%;
    }

    .english-page__photo-frame img {
        height: 100%;
        object-fit: cover;
    }

    .english-page__photo-placeholder {
        align-items: center;
        background:
            linear-gradient(145deg, rgba(123, 141, 102, 0.92) 0%, rgba(31, 26, 23, 0.92) 100%);
        color: #ffffff;
        display: flex;
        flex-direction: column;
        justify-content: center;
        min-height: 25rem;
        padding: 2rem;
        text-align: center;
    }

    .english-page__photo-placeholder span {
        font-size: 0.82rem;
        font-weight: 600;
        letter-spacing: 0.18em;
        margin-bottom: 0.85rem;
        text-transform: uppercase;
    }

    .english-page__photo-placeholder strong {
        font-size: 1.5rem;
        line-height: 1.25;
        max-width: 16rem;
    }

    .english-page__eyebrow {
        align-items: flex-start;
        display: grid;
        gap: 1rem;
        grid-template-columns: 3.75rem minmax(0, 1fr);
        margin-bottom: 1.2rem;
    }

    .english-page__flag {
        width: 4rem;
        height: 2.1rem;
        display: inline-block;
        border: 1px solid rgba(31, 26, 23, 0.15);
        box-shadow: inset 0 0 0 1px rgba(255, 255, 255, 0.4);
        background: center / 100% 100% no-repeat
            url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 60 30'%3E%3Crect width='60' height='30' fill='%23aa151b'/%3E%3Crect y='7.5' width='60' height='15' fill='%23f1bf00'/%3E%3C/svg%3E");
    }

    .english-page__flag::before,
    .english-page__flag::after {
        content: none;
    }

    .english-page__eyebrow h4 {
        font-size: 1.25rem;
        line-height: 1.25;
        margin: 0.15rem 0 0;
    }

    .english-page__copy {
        color: var(--english-muted);
        line-height: 1.75;
    }

    .english-page__copy p:last-child {
        margin-bottom: 0;
    }

    .english-page__fairs-intro {
        margin-bottom: 1.5rem;
    }

    .english-page__fair-grid {
        display: grid;
        gap: 1rem;
        grid-template-columns: repeat(3, minmax(0, 1fr));
    }

    .english-page__fair-card {
        border: 1px solid rgba(31, 26, 23, 0.1);
        box-shadow: 0 16px 32px rgba(31, 26, 23, 0.05);
        display: flex;
        flex-direction: column;
        min-height: 100%;
        padding: 1.5rem;
        text-align: center;
    }

    .english-page__fair-card--light {
        background: rgba(255, 255, 255, 0.88);
    }

    .english-page__fair-card--sage {
        background: var(--english-accent-soft);
    }

    .english-page__fair-card h5 {
        font-size: 1.15rem;
        letter-spacing: 0.06em;
        margin-bottom: 1rem;
        text-transform: uppercase;
    }

    .english-page__fair-card ul {
        color: var(--english-muted);
        list-style: none;
        margin: 0 0 1.25rem;
        padding: 0;
    }

    .english-page__fair-card li + li {
        margin-top: 0.55rem;
    }

    .english-page__fair-card a {
        color: var(--english-ink);
        font-weight: 600;
        margin-top: auto;
        text-decoration: none;
    }

    .english-page__fair-card a:hover {
        color: var(--english-accent);
    }

    .english-page__contact-row {
        align-items: stretch;
    }

    .english-page__contact-card {
        background: rgba(255, 255, 255, 0.86);
    }

    .english-page__contact-card .form-label {
        font-size: 0.84rem;
        font-weight: 600;
        letter-spacing: 0.08em;
        text-transform: uppercase;
    }

    .english-page__contact-card .form-control {
        background: #fffdf9;
    }

    .english-page__submit {
        letter-spacing: 0.12em;
        margin-top: 0.5rem;
        text-transform: uppercase;
    }

    .english-page__feedback {
        margin-bottom: 1.5rem;
        text-align: center;
    }

    .english-page__feedback .alert {
        margin-bottom: 0;
    }

    .english-page__contact-side {
        display: flex;
        flex-direction: column;
        gap: 1rem;
    }

    .english-page__contact-side p {
        color: var(--english-muted);
        line-height: 1.7;
        margin: 0;
    }

    .english-page__contact-actions {
        display: grid;
        gap: 0.85rem;
    }

    .english-page__contact-button {
        align-items: center;
        background: rgba(255, 255, 255, 0.9);
        border: 1px solid rgba(31, 26, 23, 0.12);
        color: var(--english-ink);
        display: flex;
        font-weight: 600;
        gap: 0.75rem;
        min-height: 3.35rem;
        padding: 0.95rem 1rem;
        text-decoration: none;
        transition: transform 0.2s ease, border-color 0.2s ease, box-shadow 0.2s ease;
    }

    .english-page__contact-button:hover {
        border-color: var(--english-accent);
        box-shadow: 0 10px 18px rgba(31, 26, 23, 0.08);
        color: var(--english-ink);
        transform: translateY(-1px);
    }

    .english-page__contact-button span {
        line-height: 1.3;
    }

    .english-page__contact-icon {
        align-items: center;
        background: var(--english-accent-soft);
        border-radius: 999px;
        color: var(--english-ink);
        display: inline-flex;
        flex: 0 0 2.5rem;
        height: 2.5rem;
        justify-content: center;
        width: 2.5rem;
    }

    .english-page__contact-icon svg {
        height: 1rem;
        width: 1rem;
    }

    @media (max-width: 991px) {
        .english-page {
            padding-top: 1.75rem;
        }

        .english-page__fair-grid {
            grid-template-columns: 1fr;
        }

        .english-page__photo-placeholder {
            min-height: 18rem;
        }

        .english-page__contact-side {
            margin-top: 1.5rem;
        }
    }

    @media (max-width: 767px) {
        .english-page__slider-shell,
        .english-page__text-card,
        .english-page__contact-card {
            padding: 1.25rem;
        }

        .english-page__slide-media {
            min-height: 18rem;
        }

        .english-page__slide-placeholder {
            padding: 1.4rem;
        }

        .english-page__section {
            padding: 1rem 0;
        }

        .english-page__section-title {
            gap: 0.5rem;
        }

        .english-page__section-title span {
            letter-spacing: 0.12em;
            padding: 0 0.6rem;
        }

        .english-page__eyebrow {
            grid-template-columns: 3.2rem minmax(0, 1fr);
        }

        .english-page__flag {
            height: 1.7rem;
            width: 3.2rem;
        }
    }
</style>

<section class="english-page">
    <div class="container">
        <p class="english-page__notice">E-commerce disponible solo en Brasil</p>
    </div>

    <section class="english-page__hero">
        <div class="container">
            <div class="english-page__slider-shell">
                <div class="english-page__slider-content">
                    <div class="js-swiper-english-gallery english-page__slider-carousel swiper-container">
                        <div class="english-page__slider-track swiper-wrapper">
                            {% if has_spanish_gallery %}
                                {% for slide in spanish_gallery %}
                                    <div class="english-page__slide swiper-slide">
                                        {% if slide.link %}
                                            <a href="{{ slide.link | setting_url }}" class="english-page__slide-link">
                                        {% endif %}
                                            <div class="english-page__slide-media">
                                                <img src="{{ slide.image | static_url | settings_image_url('original') }}" width="1000" height="1500" alt="Imagen de galería de Capelli Rossi {{ loop.index }}" />
                                            </div>
                                        {% if slide.link %}
                                            </a>
                                        {% endif %}
                                    </div>
                                {% endfor %}
                            {% endif %}
                        </div>
                    </div>

                    <div class="js-swiper-english-gallery-prev swiper-button-prev swiper-button-outside d-none d-md-block svg-icon-text">
                        <svg class="icon-inline icon-lg icon-flip-horizontal"><use xlink:href="#chevron"/></svg>
                    </div>
                    <div class="js-swiper-english-gallery-next swiper-button-next swiper-button-outside d-none d-md-block svg-icon-text">
                        <svg class="icon-inline icon-lg"><use xlink:href="#chevron"/></svg>
                    </div>
                    <div class="js-swiper-home-control js-swiper-home-pagination js-swiper-english-gallery-pagination swiper-pagination swiper-pagination-bullets my-3">
                        {% if spanish_gallery_slides_count > 1 and not params.preview %}
                            {% for slide in 1..spanish_gallery_slides_count %}
                                <span class="swiper-pagination-bullet"></span>
                            {% endfor %}
                        {% endif %}
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="english-page__section english-page__section--about">
        <div class="container">
            <h3 class="english-page__section-title"><span>Sobre Nosotros</span></h3>

            <div>
                <article class="english-page__text-card">
                    <div class="english-page__eyebrow">
                        <span class="english-page__flag" aria-hidden="true"></span>
                        <h4>La marca: Capelli Rossi</h4>
                    </div>

                    <div class="english-page__copy">
                        <p>Capelli Rossi es el resultado de un proyecto desarrollado y producido con amor y dedicación, enfocado en las mujeres que nos inspiran y nos motivan en cada colección.</p>
                        <p>El alma de Capelli Rossi eres tú: una mujer independiente, empoderada y segura de sí misma. Cultivas tu feminidad no como fragilidad, sino como expresión de tu fuerza. La moda es tu manera de reflejar tu personalidad, y sabes que los pequeños detalles marcan toda la diferencia.</p>
                        <p>Capelli Rossi cree en una moda sin complicaciones, combinando comodidad, calidad y diseño atractivo. La colección se desarrolla con capelladas de cuero de alta calidad y, para brindar aún más confort, nuestros zapatos cuentan con forro y plantillas de cuero.</p>
                        <p>Pensando en ti, mejoramos continuamente nuestro trabajo para poder ofrecer siempre lo mejor.</p>
                        <p>Capelli Rossi se produce en Brasil con un nombre italiano, en referencia al origen de las grandes marcas de moda, e inspirada en ti.</p>
                    </div>
                </article>
            </div>
            {% if has_admin_about_image %}
                <div class="english-page__photo-frame">
                    <img src="{{ 'institutional_spanish_about.jpg' | static_url | settings_image_url('1080p') }}" alt="Zapatos Capelli Rossi" />
                </div>
            {% endif %}

            <article class="english-page__text-card">
                <div class="english-page__eyebrow">
                    <span class="english-page__flag" aria-hidden="true"></span>
                    <h4>La fábrica: Calçados Status</h4>
                </div>

                <div class="english-page__copy">
                    <p>Calçados Status está ubicada en Igrejinha, en el sur de Brasil. Fundada en 1976, la empresa refleja una historia de éxito construida sobre un fuerte trabajo en equipo, con foco en la calidad y el respeto por las personas y el medio ambiente.</p>
                    <p>Especializada en la producción de calzado femenino de cuero, la empresa trabaja con materias primas y proveedores de alta calidad, realizando inversiones constantes en tecnología de producción orientada al confort, la calidad y productos diferenciados.</p>
                    <p>Calçados Status desarrolla y produce su propia colección, Capelli Rossi, y también trabaja en el desarrollo y la producción para marcas privadas.</p>
                    <p>Con amplia experiencia en comercio exterior, su producción está actualmente 100% dedicada a la exportación, llegando a más de 40 países.</p>
                    <p>A través de Capelli Rossi, la empresa participa en ferias internacionales como Expo Riva Schuh y MICAM en Italia, además de eventos nacionales como BFShow en São Paulo.</p>
                </div>
            </article>
        </div>
    </section>

    <section class="english-page__section english-page__section--fairs">
        <div class="container">
            <h3 class="english-page__section-title"><span>Ferias Comerciales</span></h3>

            <div class="english-page__fairs-intro">
                <article class="english-page__text-card">
                    <div class="english-page__eyebrow">
                        <span class="english-page__flag" aria-hidden="true"></span>
                        <h4>Ferias Comerciales</h4>
                    </div>

                    <div class="english-page__copy">
                        <p>Capelli Rossi participa en las ferias comerciales nacionales e internacionales más importantes. Consulta a continuación los eventos y las fechas.</p>
                        <p>Esperamos tu visita. Para más información o para agendar una reunión, por favor contáctanos.</p>
                    </div>
                </article>
            </div>

            <div class="english-page__fair-grid">
                <article class="english-page__fair-card english-page__fair-card--sage">
                    <h5>BFShow</h5>
                    <ul>
                        <li><strong>Dónde:</strong> São Paulo, Brasil</li>
                        <li><strong>Cuándo:</strong> Mayo</li>
                        <li><strong>Colección:</strong> Línea de verano</li>
                    </ul>
                    <a href="https://bfshow.com.br/" target="_blank" rel="noopener noreferrer">Visitar sitio</a>
                </article>

                <article class="english-page__fair-card english-page__fair-card--light">
                    <h5>Expo Riva Schuh</h5>
                    <ul>
                        <li><strong>Dónde:</strong> Milán, Italia</li>
                        <li><strong>Cuándo:</strong> Septiembre</li>
                        <li><strong>Colección:</strong> Línea de verano</li>
                    </ul>
                    <a href="https://exporivaschuh.it/it" target="_blank" rel="noopener noreferrer">Visitar sitio</a>
                </article>

                <article class="english-page__fair-card english-page__fair-card--sage">
                    <h5>MICAM</h5>
                    <ul>
                        <li><strong>Dónde:</strong> Milán, Italia</li>
                        <li><strong>Cuándo:</strong> Febrero</li>
                        <li><strong>Colección:</strong> Línea de verano</li>
                    </ul>
                    <a href="https://www.themicam.com/micammain/doc.html?id=21308" target="_blank" rel="noopener noreferrer">Visitar sitio</a>
                </article>

                <article class="english-page__fair-card english-page__fair-card--light">
                    <h5>MICAM</h5>
                    <ul>
                        <li><strong>Dónde:</strong> Milán, Italia</li>
                        <li><strong>Cuándo:</strong> Febrero</li>
                        <li><strong>Colección:</strong> Línea de invierno</li>
                    </ul>
                    <a href="https://www.themicam.com/micammain/doc.html?id=21308" target="_blank" rel="noopener noreferrer">Visitar sitio</a>
                </article>

                <article class="english-page__fair-card english-page__fair-card--sage">
                    <h5>BFShow</h5>
                    <ul>
                        <li><strong>Dónde:</strong> São Paulo, Brasil</li>
                        <li><strong>Cuándo:</strong> Noviembre</li>
                        <li><strong>Colección:</strong> Línea de invierno</li>
                    </ul>
                    <a href="https://bfshow.com.br/" target="_blank" rel="noopener noreferrer">Visitar sitio</a>
                </article>

                <article class="english-page__fair-card english-page__fair-card--light">
                    <h5>Expo Riva Schuh</h5>
                    <ul>
                        <li><strong>Dónde:</strong> Riva del Garda, Italia</li>
                        <li><strong>Cuándo:</strong> Enero</li>
                        <li><strong>Colección:</strong> Línea de invierno</li>
                    </ul>
                    <a href="http://www.exporivaschuh.it/" target="_blank" rel="noopener noreferrer">Visitar sitio</a>
                </article>
            </div>
        </div>
    </section>

    <section class="english-page__section english-page__section--contact">
        <div class="container">
            <h3 class="english-page__section-title"><span>Contáctanos</span></h3>

            <div class="row english-page__contact-row">
                <div class="col-lg-7">
                    {% if contact %}
                        <div class="english-page__feedback">
                            {% if contact.success %}
                                <div class="alert alert-success">Gracias por contactarnos.</div>
                            {% else %}
                                <div class="alert alert-danger">Necesitamos tu nombre y correo electrónico para responderte.</div>
                            {% endif %}
                        </div>
                    {% endif %}

                    <div class="english-page__contact-card">
                        {% embed "snipplets/forms/form.tpl" with {form_id: 'spanish-contact-form', form_custom_class: 'js-winnie-pooh-form', form_action: '/winnie-pooh', submit_custom_class: 'btn-block english-page__submit', submit_name: 'contact', submit_text: 'Enviar', data_store: 'contact-form'} %}
                            {% block form_body %}
                                <div class="d-none">
                                    <label for="winnie-pooh">No completes este campo:</label>
                                    <input type="text" id="winnie-pooh" name="winnie-pooh" />
                                </div>

                                <input type="hidden" name="type" value="contact" />

                                <div class="row">
                                    <div class="col-md-6">
                                        {% embed "snipplets/forms/form-input.tpl" with {input_for: 'name', type_text: true, input_name: 'name', input_id: 'name', input_label_text: 'Nombre', input_placeholder: 'Tu nombre', input_required: true} %}
                                        {% endembed %}
                                    </div>

                                    <div class="col-md-6">
                                        {% embed "snipplets/forms/form-input.tpl" with {input_for: 'surname', type_text: true, input_name: 'surname', input_id: 'surname', input_label_text: 'Apellido', input_placeholder: 'Tu apellido', input_required: true} %}
                                        {% endembed %}
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6">
                                        {% embed "snipplets/forms/form-input.tpl" with {input_for: 'city', type_text: true, input_name: 'city', input_id: 'city', input_label_text: 'Ciudad', input_placeholder: 'Tu ciudad', input_required: true} %}
                                        {% endembed %}
                                    </div>

                                    <div class="col-md-6">
                                        {% embed "snipplets/forms/form-input.tpl" with {input_for: 'country', type_text: true, input_name: 'country', input_id: 'country', input_label_text: 'País', input_placeholder: 'Tu país', input_required: true} %}
                                        {% endembed %}
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6">
                                        {% embed "snipplets/forms/form-input.tpl" with {input_for: 'email', type_email: true, input_name: 'email', input_id: 'email', input_label_text: 'Correo electrónico', input_placeholder: 'tu@email.com', input_required: true} %}
                                        {% endembed %}
                                    </div>

                                    <div class="col-md-6">
                                        {% embed "snipplets/forms/form-input.tpl" with {input_for: 'phone', type_tel: true, input_name: 'phone', input_id: 'phone', input_label_text: 'Teléfono', input_placeholder: '+55 51 3549 8000', input_required: true} %}
                                        {% endembed %}
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="form-label" for="message">Mensaje</label>
                                    <textarea id="message" name="message" rows="6" class="form-control form-control-area" placeholder="Escribe tu mensaje aquí" required></textarea>
                                </div>
                            {% endblock %}
                        {% endembed %}
                    </div>
                </div>

                <div class="col-lg-5">
                    <div class="english-page__contact-card english-page__contact-side">
                        <p>Para citas, consultas de ventas internacionales o proyectos de marca privada, habla directamente con nuestro equipo a través de los canales a continuación.</p>

                        <div class="english-page__contact-actions">
                            <a class="english-page__contact-button" href="tel:+555135498000">
                                <span class="english-page__contact-icon">+55</span>
                                <span>+55 51 3549 8000</span>
                            </a>

                            <a class="english-page__contact-button" href="https://www.facebook.com/capellirossishoes/" target="_blank" rel="noopener noreferrer">
                                <span class="english-page__contact-icon">
                                    <svg aria-hidden="true"><use xlink:href="#facebook-f"></use></svg>
                                </span>
                                <span>Facebook</span>
                            </a>

                            <a class="english-page__contact-button" href="https://www.instagram.com/capelli_rossi_shoes/" target="_blank" rel="noopener noreferrer">
                                <span class="english-page__contact-icon">
                                    <svg aria-hidden="true"><use xlink:href="#instagram"></use></svg>
                                </span>
                                <span>Instagram</span>
                            </a>

                            <a class="english-page__contact-button" href="https://maps.app.goo.gl/GVHZFKWpE23qCjfD9" target="_blank" rel="noopener noreferrer">
                                <span class="english-page__contact-icon">
                                    <svg aria-hidden="true"><use xlink:href="#map-marker-alt"></use></svg>
                                </span>
                                <span>Ubicación en Google Maps</span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</section>
