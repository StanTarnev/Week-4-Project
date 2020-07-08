class SqlHelper
    def self.get_bool(bool)
        psql_hash = {
            't' => '✔️',
            'f' => '❌',
            'true' => '✔️',
            'false' => '❌'
        }

        if !!bool == bool
            return bool
        else
            return psql_hash[bool]
        end
    end
end
