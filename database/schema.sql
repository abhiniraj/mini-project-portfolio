-- Portfolio Database Schema
-- This script creates the necessary database and tables for the portfolio website

-- Create database
CREATE DATABASE IF NOT EXISTS portfolio_db;
USE portfolio_db;

-- Table: contact_messages
-- Stores all contact form submissions
CREATE TABLE IF NOT EXISTS contact_messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    subject VARCHAR(200) NOT NULL,
    message TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_read BOOLEAN DEFAULT FALSE,
    INDEX idx_email (email),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: portfolio_views (Optional - for analytics)
-- Tracks page views and visitor statistics
CREATE TABLE IF NOT EXISTS portfolio_views (
    id INT AUTO_INCREMENT PRIMARY KEY,
    page_url VARCHAR(255) NOT NULL,
    visitor_ip VARCHAR(45),
    user_agent TEXT,
    visited_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_page_url (page_url),
    INDEX idx_visited_at (visited_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: projects (Optional - if you want to manage projects via database)
-- Stores project information
CREATE TABLE IF NOT EXISTS projects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    category VARCHAR(50) NOT NULL,
    description TEXT NOT NULL,
    technologies VARCHAR(500),
    github_url VARCHAR(255),
    demo_url VARCHAR(255),
    image_url VARCHAR(255),
    is_featured BOOLEAN DEFAULT FALSE,
    display_order INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_category (category),
    INDEX idx_featured (is_featured)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: certifications (Optional - if you want to manage certifications via database)
-- Stores certification information
CREATE TABLE IF NOT EXISTS certifications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    issuer VARCHAR(100) NOT NULL,
    issue_date DATE NOT NULL,
    credential_url VARCHAR(255),
    skills VARCHAR(500),
    display_order INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_issuer (issuer),
    INDEX idx_issue_date (issue_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert sample data for testing (Optional)
-- Sample contact message
INSERT INTO contact_messages (name, email, subject, message) VALUES
('John Doe', 'john.doe@example.com', 'Great Portfolio!', 'I really enjoyed browsing through your portfolio. Your work is impressive!');

-- Sample projects
INSERT INTO projects (title, category, description, technologies, github_url, demo_url, is_featured, display_order) VALUES
('E-Commerce Website', 'fullstack', 'A complete e-commerce platform with shopping cart and payment integration.', 'HTML,CSS,JavaScript,PHP,MySQL', 'https://github.com/yourusername/ecommerce', '#', TRUE, 1),
('Weather Dashboard', 'javascript', 'Real-time weather application using OpenWeatherMap API.', 'HTML,CSS,JavaScript,API', 'https://github.com/yourusername/weather', '#', TRUE, 2),
('Task Manager', 'javascript', 'Interactive task management app with drag-and-drop functionality.', 'HTML,CSS,JavaScript', 'https://github.com/yourusername/taskmanager', '#', FALSE, 3);

-- Sample certifications
INSERT INTO certifications (name, issuer, issue_date, credential_url, skills, display_order) VALUES
('Web Development Bootcamp', 'Udemy', '2024-01-15', 'https://udemy.com/certificate/UC-XXXXXXXX', 'HTML,CSS,JavaScript,Node.js', 1),
('JavaScript Algorithms', 'freeCodeCamp', '2023-11-20', 'https://freecodecamp.org/certification/user/javascript', 'JavaScript,Algorithms,Data Structures', 2),
('Responsive Web Design', 'freeCodeCamp', '2023-09-10', 'https://freecodecamp.org/certification/user/responsive-web', 'HTML,CSS,Flexbox,Grid', 3);

-- Create a user for the portfolio application (Optional)
-- Replace 'portfolio_user' and 'secure_password' with your preferred credentials
-- GRANT ALL PRIVILEGES ON portfolio_db.* TO 'portfolio_user'@'localhost' IDENTIFIED BY 'secure_password';
-- FLUSH PRIVILEGES;
