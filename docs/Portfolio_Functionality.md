Portfolio Project — Functionality & Flow

Overview
- Project: Personal portfolio site for `Abhiniraj K`.
- Location: project root (static files in `index.html`, assets in `css/`, `js/`, `images/`, optional server files in `php/`).
- Hosted: GitHub Pages via `gh-pages` branch at https://abhiniraj.github.io/mini-project-portfolio/

Core Technologies
- HTML: `index.html` — page sections for Profile, Skills, Education, Projects, Achievements, Certifications, Contact.
- CSS: `css/style.css` — layout, hero/banner, profile card, responsive rules. Uses Google font `Inter`.
- JavaScript: `js/main.js` — small enhancements (auto year update, previously had XSLT/contact handlers removed).
- PHP (optional server): `php/contact.php`, `php/db.php`, `php/test_db.php` — contact endpoint (tries DB then file fallback), DB connection helper, and a DB test script.
- MySQL: `sql/schema.sql` — schema for `messages` table used by `php/contact.php` when DB enabled.
- Data fallback: `data/messages.txt` — appended messages if DB unavailable.
- Automation: `scripts/install_xampp.ps1` — helper to download XAMPP and optionally copy project to `htdocs`.

Main UI & UX elements
- Hero/Banner: prominent heading and call-to-action linking to projects.
- Profile card: small avatar and short bio in the `#profile` section.
- Projects grid: responsive cards in `#projects` (uses CSS grid `auto-fit` to size cards).
- Contact: static contact details in `#contact` (interactive contact form was removed per user request; PHP endpoints remain optional).

Server-side flow (contact)
1. Client (if interactive form enabled) would POST to `php/contact.php`.
2. `php/contact.php` attempts to include `php/db.php` and insert message into MySQL (`portfolio_db.messages`) using prepared statements.
3. If DB connection or insert fails, it appends a timestamped, tab-delimited entry to `data/messages.txt`.
4. `php/contact.php` returns a JSON result indicating `stored: db` or `stored: file`.
5. `php/test_db.php` is available to create the table and verify DB connectivity.

Development & Local Testing
- Static preview: open `index.html` directly or run a quick server:`python -m http.server 8000`.
- PHP testing: install XAMPP (Windows) or use local PHP. The included `scripts/install_xampp.ps1` automates download and copy.
- Git & Deployment: repository was initialized and pushed to GitHub. `gh-pages` branch is used for Pages publishing.

Files of interest (paths relative to project root)
- `index.html` — main site
- `css/style.css` — styling
- `js/main.js` — small scripts
- `images/` — `profile.jpg`, `bg.jpg` placeholders
- `resume/Resume.pdf` — downloadable resume
- `php/contact.php`, `php/db.php`, `php/test_db.php`
- `data/messages.txt` — message fallback store
- `sql/schema.sql` — DB schema
- `scripts/install_xampp.ps1` — installer helper

Design & Layout Decisions
- Mobile-first single-column layout: simplified for clarity and readability across widths.
- Section background gradients: provide gentle visual separation without heavy imagery.
- Emoji heading icons: avoid external icon assets and keep bundle small.
- Profile card and resume link prioritized near top for recruiter flow.

Publishing
- GitHub Pages: site served from `gh-pages` branch — URL: `https://abhiniraj.github.io/mini-project-portfolio/`.
- Notes: GitHub Pages serves only static assets. PHP scripts are kept in repo for completeness but won't run on Pages.

Future work / Recommendations
- Replace placeholder images with optimized photos (add `images/profile.jpg` and `images/bg.jpg`).
- If contact form is needed in production, use a hosted server for `php/` code or switch to a serverless form provider (Formspree, Netlify forms).
- Add `404.html` and meta/social tags for better sharing.
- Consider minifying CSS/JS for performance and adding a small build step if the project grows.


Flow Diagram (linear):
1. Developer edits files -> commits -> pushes to GitHub -> `gh-pages` branch updated
2. GitHub Pages publishes site -> users open site URL
3. (Optional) Form submit -> `php/contact.php` on server -> DB or fallback file -> admin reads `data/messages.txt` or DB

Design Diagrams

Below are two illustrative diagrams included in the `docs/images/` folder:

- `design_diagram.svg` — high-level architecture showing the browser, GitHub Pages static hosting, static assets, and the optional PHP+MySQL server used locally (XAMPP).
- `flowchart.svg` — a simple flowchart that shows the request flow and the optional contact form branch (static contact vs server-side processing).

You can view these images directly on GitHub or locally by opening the files in a browser: `docs/images/design_diagram.svg` and `docs/images/flowchart.svg`.

Contact
- Repo: https://github.com/abhiniraj/mini-project-portfolio
- Live: https://abhiniraj.github.io/mini-project-portfolio/

---
Generated: a short summary ready for conversion to Word (.docx).