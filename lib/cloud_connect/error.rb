module CloudConnect
  class Error < StandardError; end
  class BadGateway < Error; end
  class BadRequest < Error; end
  class Forbidden < Error; end
  class InternalServerError < Error; end
  class NotAcceptable < Error; end
  class NotFound < Error; end
  class ServiceUnavailable < Error; end
  class UnprocessableEntity < Error; end
  class Unauthorized < Error; end
end
