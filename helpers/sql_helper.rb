class SqlHelper
    def self.get_bool(bool)
        psql_hash = {
            't' => true,
            'f' => false,
            'true' => true,
            'false' => false
        }

        if !!bool == bool
            return bool
        else
            return psql_hash[bool]
        end
    end
end
