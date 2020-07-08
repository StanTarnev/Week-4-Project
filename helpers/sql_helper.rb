class SqlHelper
    def self.get_bool(bool)
        psql_hash = {
            't' => 'Yes',
            'f' => 'No',
            'true' => 'Yes',
            'false' => 'No'
        }

        if !!bool == bool
            return bool
        else
            return psql_hash[bool]
        end
    end
end
