module WOTC
  class Client
    # Defines methods related to webhooks.
    module Webhooks
      # List company webhooks
      def webhooks(options={})
        paginate('webhooks')
      end

      # Create a webhook
      def create_webhook(options = {})
        post('webhooks', options)
      end

      # Update a webhook
      def update_webhook(webhook_id, options = {})
        put("webhooks/#{webhook_id}", options)
      end

      # Delete a webhook
      def delete_webhook(webhook_id)
        delete("webhooks/#{webhook_id}")
      end
    end
  end
end