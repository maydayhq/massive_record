module MassiveRecord
  module ORM
    module Relations
      module Interface
        extend ActiveSupport::Concern

        included do
          class_attribute :relations, :instance_writer => false
          self.relations = Set.new
        end


        module ClassMethods
          def references_one(name, *args)
            metadata = Metadata.new(name, *args)
            metadata.relation_type = 'references_one'
            raise RelationAlreadyDefined unless self.relations.add?(metadata)
            create_references_one_accessors(metadata)
          end

          private


          def create_references_one_accessors(metadata)
            redefine_method(metadata.name) do
              relation_proxy(metadata.name).target
            end

            redefine_method(metadata.name+'=') do |record|
              relation_proxy(metadata.name).replace(record)
            end

            if metadata.persisting_foreign_key?
              add_field_to_column_family(metadata.store_foreign_key_in, metadata.foreign_key)
            end
          end
        end



        private

        def relation_proxy(name)
          name = name.to_s

          unless proxy = relation_proxy_get(name)
            if metadata = relations.find { |meta| meta.name == name }
              proxy = metadata.new_relation_proxy(self)
              relation_proxy_set(name, proxy)
            end
          end

          proxy
        end

        def relation_proxy_get(name)
          @relation_proxy_cache[name.to_s]
        end

        def relation_proxy_set(name, proxy)
          @relation_proxy_cache[name.to_s] = proxy
        end
      end
    end
  end
end
