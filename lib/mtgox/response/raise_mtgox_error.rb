require "faraday"

module MtGox
  class Response
    class RaiseMtGoxError < Faraday::Response::Middleware
      def on_complete(env)
        if 200 == env[:status] && "MySQL error, please retry later" == env[:body]
          raise MtGox::MysqlError, "MySQL error, please retry later"
        else 
          begin
            body = JSON.parse(env[:body])
            if body["result"] == "error"
              raise MtGox::Error, body["error"]
            end
          rescue JSON::ParserError
          end
        end
      end
    end
  end
end
