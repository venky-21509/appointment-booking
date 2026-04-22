<div align="center">

# 📅 Appointment Booking System

[![Rails](https://img.shields.io/badge/Rails-8.0.4-red.svg)](https://rubyonrails.org/)
[![Ruby](https://img.shields.io/badge/Ruby-3.3.0-red.svg)](https://www.ruby-lang.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-blue.svg)](https://www.postgresql.org/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

**A modern, full-stack web application built with Ruby on Rails for managing and scheduling appointments with role-based access control and a beautiful user interface.**

🌐 **Live Demo:** https://appointment-booking-yr62.onrender.com

[Features](#-features) • [Tech Stack](#-tech-stack) • [Installation](#-installation) • [Usage](#-usage) • [API](#-api) • [Deployment](#-deployment)

</div>

---

## ✨ Features

- **User Authentication**: Secure authentication with Devise
- **Appointment Management**: Create, update, and manage appointments
- **Status Workflow**: Track appointments (New → Confirmed → Completed → Received → Cancelled)
- **File Uploads**: Attach documents to appointments
- **Search & Filter**: Search appointments by ID, provider, package, or status
- **CSV Export**: Download appointment data as CSV
- **Admin Dashboard**: Powerful ActiveAdmin interface for managing customers and appointments
- **Responsive Design**: Modern UI that works on desktop and mobile

---

## 🛠️ Tech Stack

- **Ruby 3.3.0** - Programming language
- **Rails 8.0.4** - Web framework
- **PostgreSQL** - Database
- **Devise 4.9** - Authentication
- **ActiveAdmin 3.4** - Admin interface
- **AASM** - State machine for appointment workflow
- **CarrierWave** - File uploads
- **Hotwire** (Turbo + Stimulus) - Frontend framework
- **Solid Queue** - Background jobs
- **Solid Cache** - Caching
- **Kamal** - Deployment tool
- **Docker** - Containerization

---

## 📦 Installation

### Prerequisites
- Ruby 3.3.0 or higher
- PostgreSQL 16 or higher
- Node.js
- Git

### Setup

```bash
# Clone the repository
git clone https://github.com/venky-21509/appointment-booking.git
cd appointment-booking

# Install dependencies
bundle install

# Setup database
rails db:create db:migrate

# Seed database (optional)
rails db:seed

# Start the server
rails server
```

Visit `http://localhost:3000`

---

## 🚀 Usage

### Customer Workflow
1. Sign up with email, name, and mobile number
2. Book appointments by selecting date, time, provider, and package
3. Upload attachments (optional)
4. Track appointment status
5. Edit or cancel appointments

### Admin Workflow
1. Login at `/admin`
2. Manage customers and appointments
3. Update appointment status
4. Reset customer passwords

---

## 🔌 API

### Endpoints

```
GET    /api/appointments          # List all appointments
GET    /api/appointments/:id      # Get single appointment
POST   /api/appointments          # Create appointment
PUT    /api/appointments/:id      # Update appointment
DELETE /api/appointments/:id      # Delete appointment
```

**Note**: API endpoints currently skip authentication. Implement proper authentication for production.

---

## 🐳 Deployment

### Docker

```bash
# Build image
docker build -t appointment_booking .

# Run container
docker run -d -p 80:80 -e RAILS_MASTER_KEY=your_key appointment_booking
```

### Kamal

```bash
kamal deploy
```

---

## 🧪 Testing

```bash
# Run tests
bundle exec rspec

# Security scan
bundle exec brakeman

# Code style check
bundle exec rubocop
```

---

## 🔐 Security

- Content Security Policy enabled
- File upload extension whitelist
- Time validation for appointments
- Transaction-based operations
- Environment variable configuration
- CSRF protection

---

## 📝 License

MIT License

---

## 👨‍💻 Author

**Venkatesh Pothem**

- GitHub: [@venky-21509](https://github.com/venky-21509)
- Live Demo: https://appointment-booking-yr62.onrender.com

---

<div align="center">

**Built with ❤️ using Ruby on Rails**

</div>
