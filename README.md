# Personal Portfolio Website

This repository is a template/personal portfolio website that demonstrates the Web Programming syllabus concepts:

- HTML / XHTML
- CSS
- JavaScript (client-side + AJAX)
- PHP (contact form server-side; file-based storage)
- GitHub: public repository & GitHub Pages hosting (static part)

Project structure

- `index.html` — main static site (serves as GitHub Pages entry point)
- `css/` — styles
- `js/` — client-side JavaScript
- (No XML/XSLT demo included)
- `php/` — PHP endpoint `contact.php` and `db.php` helper
- `data/messages.txt` — fallback storage for messages when DB is not available
- `sql/schema.sql` — SQL to create `portfolio_db` and `messages` table
- `resume/Resume.pdf` — placeholder resume (replace with your PDF)

Important: GitHub Pages cannot run server-side code. This project currently uses file-based storage only — the contact form stores messages to `data/messages.txt` on the server filesystem. For GitHub Pages (static hosting) the contact form will not function because Pages does not run PHP. To use the contact form, host the project on a PHP-capable host or run a local PHP server.

Note about PHP + MySQL (your choice)
 - Note about PHP + MySQL

This repository now includes optional MySQL support for the contact form.

What was added:
- `php/db.php`: helper to connect to MySQL (update credentials as needed).
- `sql/schema.sql`: SQL to create `portfolio_db` and the `messages` table.
- `php/contact.php`: updated to try inserting messages into MySQL first; if the DB is unavailable or insertion fails it falls back to appending to `data/messages.txt`.

Quick setup steps (Windows + XAMPP example):

1. Install XAMPP and start Apache + MySQL.
2. Open `phpMyAdmin` (usually at `http://localhost/phpmyadmin`) or use the MySQL CLI to run the schema:

```sql
SOURCE sql/schema.sql;
```

3. Edit `php/db.php` to set `DB_USER`/`DB_PASS` if your MySQL user isn't `root` with empty password.
4. Ensure the `data/` folder is writable by your PHP process (fallback storage).
5. Run the built-in PHP server for quick testing or place the project in your server's document root:

```powershell
php -S localhost:8000 -t .
```

Testing the contact form

- Submit the form (if you re-enable it) or POST to `php/contact.php`. The script will return JSON with `status` and `stored` equal to either `db` or `file` depending on where the message was saved.

If you'd like, I can also add a small `php/test_db.php` file that performs a test insert/select so you can confirm your DB configuration immediately.

Database test script

A small helper `php/test_db.php` has been added. To use it:

1. Ensure MySQL is running and `php/db.php` contains correct credentials.
2. Place the project in your webserver root or run the built-in server:

```powershell
php -S localhost:8000 -t .
```

3. Open in your browser:

    http://localhost:8000/php/test_db.php

The script will attempt to create the `messages` table (if missing), insert a test row, and print the current messages count. Remove the `php/test_db.php` file when you're finished verifying connectivity.

How to run PHP files locally (Windows)

1. Install XAMPP or another PHP-capable stack if you want a full environment. This project does not require MySQL.
2. Copy this project into your web server's document root (for XAMPP: `C:\xampp\htdocs\portfolio`), or run the PHP built-in server for quick testing.

Example PowerShell command to run the built-in server from the project folder:

    php -S localhost:8000 -t .

3. Ensure `data/` is writable by the PHP process so that `php/contact.php` can append messages to `data/messages.txt`.

4. Open `http://localhost:8000/index.html` (or `http://localhost/portfolio/index.html` for XAMPP) and test the contact form. Messages will be saved to `data/messages.txt`.

GitHub Pages (static hosting)

1. Create a new public GitHub repository and push this project.
2. In the repository Settings -> Pages, choose the branch and folder (root or `docs/`) to publish.
3. Note: PHP endpoints will not work on Pages. The static parts (HTML/CSS/JS/XML/XSLT) will work; contact form requires a PHP host.

Suggested next steps

- Replace placeholder content in `index.html`, `xml/profile.xml`, and `xslt/profile.xslt` with your personal information and projects.
- Add your `resume/Resume.pdf` file.
- Commit and push to a public GitHub repository, then enable GitHub Pages for the static site.

Contact

If you want, I can help:

- Customize the layout and design
- Add project pages and images
- Add instructions for deploying the PHP parts to free hosts
