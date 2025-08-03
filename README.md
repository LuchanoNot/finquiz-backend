# FinQuiz Backend

A Rails API backend for an AI-powered quiz platform designed for students to practice specific subjects. The system generates personalized multiple-choice questions using a LLM integration and provides learning analytics for both students and teachers.

## Table of Contents

- [Technology Stack](#technology-stack)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration](#configuration)
- [Running the Application](#running-the-application)
- [Testing](#testing)
- [API Documentation](#api-documentation)
- [Proyect Structure](#project-structure)

## Technology Stack

- **Framework**: Ruby on Rails 8.0.2 (API-only)
- **Ruby Version**: 3.4.2
- **Database**: PostgreSQL
- **Authentication**: Devise + DeviseTokenAuth (JWT-based)
- **Authorization**: CanCanCan for role-based permissions
- **AI Integration**: Consumes LLM API (OpenAI, Gemini, Anthropic, etc.) via ruby-openai gem
- **Background Jobs**: Sidekiq with Solid Queue
- **Caching**: Solid Cache (database-backed)
- **CORS**: Rack-CORS for cross-origin requests
- **Testing**: RSpec with FactoryBot, Shoulda Matchers
- **Code Quality**: RuboCop Rails Omakase, Brakeman, Overcommit

## Prerequisites

Before installing the application, ensure you have the following software installed on your system:

### Required Software

1. **Ruby 3.4.2**
   ```bash
   # Check your Ruby version
   ruby --version
   # Should output: ruby 3.4.2
   
   # Install via rbenv (recommended)
   rbenv install 3.4.2
   rbenv global 3.4.2
   
   # Or via RVM
   rvm install 3.4.2
   rvm use 3.4.2 --default
   ```

2. **PostgreSQL**
   ```bash
   # macOS (via Homebrew)
   brew install postgresql
   brew services start postgresql
   
   # Ubuntu/Debian
   sudo apt-get install postgresql postgresql-contrib
   sudo systemctl start postgresql
   
   # Verify installation
   psql --version
   ```

3. **Redis**
   ```bash
   # macOS (via Homebrew)
   brew install redis
   
   # Ubuntu/Debian
   sudo apt-get install redis-server
   
   # Verify installation
   redis-server --version
   ```

4. **Bundler** (Ruby gem manager)
   ```bash
   # Install bundler (usually comes with Ruby)
   gem install bundler
   
   # Verify installation
   bundle --version
   ```

## Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/LuchanoNot/finquiz-backend.git
   cd finquiz-backend
   ```

2. **Install Ruby dependencies**
   ```bash
   bundle install
   ```

3. **Database setup**
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
    ```

## Configuration

### Required Environment Variables

1. **Copy the example environment file**
   ```bash
   cp .env.example .env
   ```

2. **Update GEMINI_API_KEY**:
   - Obtain a Gemini API key and set it in your `.env` file:
   ```env
   GEMINI_API_KEY=your_gemini_api_key_here
   ```

> **Note**: Without a valid Gemini API key, the AI question generation will not work, and questionnaire creation will fail.

## Running the Application

### Development Mode

1. **Start the Rails server**
   ```bash
   bin/dev
   ```

3. **Start Redis (in separate terminal)**
   ```bash
   redis-server
   ```

2. **Start Sidekiq (in separate terminal)**
   ```bash
   bundle exec sidekiq
   ```

## Testing

The application uses RSpec for testing with comprehensive test coverage.

### Running Tests

```bash
# Run all tests
bundle exec rspec

# Run specific test files
bundle exec rspec spec/models/
bundle exec rspec spec/controllers/
```

### Test Tools
- **RSpec**: Main testing framework
- **FactoryBot**: Test data generation
- **Shoulda Matchers**: Rails-specific matchers
- **Database Cleaner**: Test database cleanup
- **Faker**: Realistic fake data generation

## API Documentation

### Authentication

The API uses token-based authentication with DeviseTokenAuth. Include these headers in requests:

```
access-token: <token>
client: <client>
uid: <uid>
```

### Main Endpoints

#### Authentication
- `POST /api/v1/auth/sign_in` - User login
- `POST /api/v1/auth/sign_up` - User registration
- `DELETE /api/v1/auth/sign_out` - User logout

#### Courses
- `GET /api/v1/courses/:id` - Get course details
- `PUT /api/v1/courses/:id` - Update course (teachers only)
- `GET /api/v1/courses/:id/reports` - Course analytics (teachers only)
- `GET /api/v1/courses/:id/questions_csv` - Export questions as CSV

#### Units & Topics
- `POST /api/v1/courses/:course_id/units` - Create unit
- `GET /api/v1/courses/:course_id/units/:id` - Get unit details
- `PUT /api/v1/courses/:course_id/units/:id` - Update unit
- `POST /api/v1/courses/:course_id/units/:unit_id/topics` - Create topic

#### Questionnaires
- `GET /api/v1/questionnaires` - List user questionnaires
- `POST /api/v1/questionnaires` - Create new questionnaire
- `GET /api/v1/questionnaires/:id` - Get questionnaire details
- `GET /api/v1/questionnaires/:id/summary` - Get questionnaire summary

#### Questions
- `GET /api/v1/questionnaires/:questionnaire_id/questions/:id` - Get question
- `POST /api/v1/questionnaires/:questionnaire_id/questions/:id/answer` - Submit answer
- `POST /api/v1/questionnaires/:questionnaire_id/questions/:id/vote` - Vote on question

### Monitoring

- **Development**: Visit `http://localhost:3000/sidekiq` for Sidekiq Web UI

## Project Structure

```
app/
├── controllers/
│   ├── api/
│   │   ├── application_controller.rb
│   │   └── v1/
│   │       ├── courses_controller.rb
│   │       ├── questionnaires_controller.rb
│   │       ├── questions_controller.rb
│   │       └── ...
│   └── concerns/
├── jobs/
│   ├── generate_questions_job.rb
│   └── ...
├── models/
│   ├── course.rb
│   ├── user.rb
│   ├── questionnaire.rb
│   ├── question.rb
│   └── abilities/
└── services/
    ├── question_gen_service.rb
    ├── m_c_q_generation_service.rb
    ├── distractors_gen_service.rb
    └── prompts/
```
