# Blog Application RESTful API

## Overview

This project implements a Blog Application RESTful API using Ruby on Rails, PostgreSQL, Sidekiq, and Redis. It includes user authentication with JWT, CRUD operations for posts, and comment management features.

## Features

- **Authentication**:
  - Users can sign up and log in using their email and password.
  - JWT is used for API authentication.
  - All other API endpoints require authentication.

- **CRUD Operations for Posts**:
  - Each post has fields: title, body, author (user), tags, and comments.
  - Authors can only edit/delete their own posts.
  - Users can add comments to any post.
  - Authors can only edit/delete their own comments.
  - Authors can update post tags.
  - Each post must have at least one tag.
  - Posts are automatically deleted 24 hours after creation using Sidekiq and Redis for scheduling.

## Tech Stack

- **Framework**: Ruby on Rails
- **Database**: PostgreSQL
- **Background Job Processing**: Sidekiq with Redis

## Docker Setup

This project uses Docker Compose to manage the development environment. Follow these steps to run the project:

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd blog_app
