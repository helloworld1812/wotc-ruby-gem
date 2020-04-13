module WOTC
  class Client
    # Defines methods related to documents
    module Documents

      # Upload a document
      # def upload_document
      #
      # end

      # Update a document
      # def update_document
      #
      # end

      # List documents
      def all_documents(options={})
        paginate("documents", options)
      end
    end
  end
end