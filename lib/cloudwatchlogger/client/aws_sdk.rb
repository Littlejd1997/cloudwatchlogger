require File.join(File.dirname(__FILE__), 'aws_sdk', 'threaded')

module CloudWatchLogger
  module Client
    class AWS_SDK
      include CloudWatchLogger::Client::InstanceMethods

      attr_reader :input_uri, :deliverer, :exception_handler

      def initialize(credentials, log_group_name, log_stream_name, opts={}, exception_handler: nil)
        setup_credentials(credentials)
        setup_log_group_name(log_group_name)
        setup_log_stream_name(log_stream_name)
        @deliverer = CloudWatchLogger::Client::AWS_SDK::DeliveryThreadManager.new(@credentials, @log_group_name, @log_stream_name, opts, exception_handler)
      end

      def write(message)
        @deliverer.deliver(message)
      end

      def close
        nil
      end
    end
  end
end