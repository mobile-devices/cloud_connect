require 'multi_json'

module CloudConnect
  module Request
    def delete(path, options={}, raw=false, force_urlencoded=false)
      request(:delete, path, options, raw, force_urlencoded)
    end

    def get(path, options={}, raw=false, force_urlencoded=false)
      request(:get, path, options, raw, force_urlencoded)
    end

    def patch(path, options={}, raw=false, force_urlencoded=false)
      request(:patch, path, options, raw, force_urlencoded)
    end

    def post(path, options={}, raw=false, force_urlencoded=false)
      request(:post, path, options, raw, force_urlencoded)
    end

    def put(path, options={}, raw=false, force_urlencoded=false)
      request(:put, path, options, raw, force_urlencoded)
    end

    private

      def request(method, path, options, raw, force_urlencoded)
        path.sub(%r{^/}, '') # prevent leading slash
        response = connection(raw, force_urlencoded).send(method) do |request|
          request.headers['Accept'] = 'application/json'

          case method
          when :delete, :get
            if auto_traversal && per_page.nil?
              self.per_page = 100
            end
            options.merge!(:per_page => per_page) if per_page
            request.url(path, options)
          when :patch, :post, :put
            request.path = path
            if !force_urlencoded
              request.body = MultiJson.dump(options) unless options.empty?
            else
              request.body = options unless options.empty?
            end
            puts request.inspect
          end

          request.headers['Host'] = CloudConnect.request_host if CloudConnect.request_host
        end

        if raw
          response
        elsif auto_traversal && ( next_url = links(response)["next"] )
          response.body + request(method, next_url, options, raw, force_urlencoded)
        else
          response.body
        end
      end

      def links(response)
        links = ( response.headers["Link"] || "" ).split(', ').map do |link|
          url, type = link.match(/<(.*?)>; rel="(\w+)"/).captures
          [ type, url ]
        end

        Hash[ *links.flatten ]
      end
  end
end
