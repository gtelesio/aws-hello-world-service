# 📮 Postman Collection - AWS Hello World Service

This folder contains a complete Postman collection to test all endpoints of the Hello World service implemented with DDD and Clean Architecture, including versioned APIs (v1, v2).

## 🚀 How to use the collection

### 1. Import the collection
1. Open Postman
2. Click "Import" in the top left corner
3. Select the file `AWS-Hello-World-Service.postman_collection.json`
4. The collection will be imported automatically

### 2. Configure variables
The collection includes predefined variables:
- **`baseUrl`**: Base URL of the service (default: `http://localhost:3000`)
- **`correlationId`**: Unique correlation ID for each request (generated automatically)

### 3. Change base URL for production
If you want to test the service deployed on AWS:
1. Click the gear icon (⚙️) in the top right corner
2. Select the "AWS Hello World Service" collection
3. Change the value of `baseUrl` to your ALB URL (e.g., `http://your-alb-url.region.elb.amazonaws.com`)

## 📋 Included endpoints

### 🏠 Basic endpoints
- **GET /** - Service information and available endpoints
- **GET /health** - Global service health check

### 📚 API Versions

#### V1 API
- **GET /api/v1/hello-world** - Hello World message (default: English)
- **GET /api/v1/hello-world?language=es** - Message in Spanish
- **GET /api/v1/hello-world?language=fr** - Message in French
- **GET /api/v1/hello-world?language=de** - Message in German
- **GET /api/v1/hello-world?language=it** - Message in Italian
- **GET /api/v1/hello-world?language=pt** - Message in Portuguese
- **POST /api/v1/hello-world** - Create custom message
- **GET /api/v1/hello-world/languages** - List of supported languages
- **GET /api/v1/health** - API health check

#### V2 API (Enhanced features)
- **GET /api/v2/hello-world** - Hello World message with format options
- **GET /api/v2/hello-world?format=minimal** - Minimal response format
- **POST /api/v2/hello-world** - Create custom message with metadata support
- **GET /api/v2/hello-world/languages** - Enhanced language information
- **GET /api/v2/health** - Enhanced health check with feature details

### ❌ Error handling
- **GET /api/v1/hello-world?language=invalid** - Invalid language error
- **POST /api/v1/hello-world** - Invalid JSON error
- **GET /api/v1/nonexistent** - 404 error (nonexistent endpoint)
- **PUT /api/v1/hello-world** - 405 error (method not allowed)

## 🔧 Collection features

### ✅ Automatic tests
Each request includes automatic tests that validate:
- HTTP 200 status code
- Presence of required fields (`status`, `message`, `correlationId`)
- Correlation ID match between sent and received

### 🆔 Correlation ID
- Each request automatically generates a unique `correlationId`
- Sent in the `x-correlation-id` header
- Validated to match in the response for tracing

### 📝 Automatic logs
- Each request is logged in the Postman console
- Each response is logged for debugging

## 🌍 Supported languages

The service supports the following languages:
- **en** - English (default)
- **es** - Spanish
- **fr** - French
- **de** - German
- **it** - Italian
- **pt** - Portuguese

## 📊 Response format

### Success response
```json
{
  "status": "OK",
  "message": "Operation completed successfully",
  "data": {
    "message": "Hello World",
    "language": "en",
    "timestamp": "2025-01-27T00:00:00.000Z"
  },
  "correlationId": "c8f7c6d4-1b1a-4d2e-9d91-93a8b9d6e7d5"
}
```

### Error response
```json
{
  "status": "ERROR",
  "message": "Could not process the request",
  "errorCode": "HELLO_001",
  "details": "The specified language is not valid",
  "correlationId": "c8f7c6d4-1b1a-4d2e-9d91-93a8b9d6e7d5",
  "timestamp": "2025-01-27T00:00:00.000Z"
}
```

## 🆕 V2 API Enhancements

### Format options
- **full** (default): Complete response with all fields
- **minimal**: Simplified response with essential data only

### Metadata support
- Include additional context in custom messages
- Track source, user ID, category, etc.

### Enhanced language information
- Language codes, names, and native names
- Total count and API version details

### Feature discovery
- Health check includes available features
- API version information in responses

## 🚨 Troubleshooting

### Connection error
- Verify the service is running
- Confirm the base URL is correct
- Check that the port is open

### Validation error
- Verify the JSON body is valid
- Confirm query parameters are correct
- Check that the `Content-Type` header is `application/json`

### CORS error
- The service includes CORS configured for development
- In production, verify ALB configuration

## 📚 Additional resources

- [Service documentation](../README.md)
- [API specification](../app/README.md)
- [Deployment guide](../infra/README.md)

---

**Note**: This collection is designed to test both the local service and the one deployed on AWS. Just change the `baseUrl` variable according to the environment you want to test. The service now only supports versioned APIs (v1 and v2) for better maintainability and feature evolution.
