require 'arkrb/error'
require 'arkrb/server/mod'
module Arkrb
  class Mods
    def initialize
      @mod_list = []
    end

    # @return [Arkrb::Mod, Exception]
    def find_by_id(id)
      mod = @mod_list.find {|m| m.id == id}
      if mod.nil?
        raise Arkrb::Error::ModIDNotFound, "Mod #{id} was not found in the mod list!"
      else
        mod
      end
    end

    # @return [Arkrb::Mod, Exception]
    def add(id)
      begin
        find_by_id(id)
        raise Arkrb::Error::ModAlreadyExists, "Mod #{id} already exists in the mod list!"
      rescue Arkrb::Error::ModIDNotFound
        mod = Arkrb::Mod.new(id)
        @mod_list << mod
        mod
      end
    end

    # @return [True, Exception]
    def delete(id)
      find_by_id(id)
      @mod_list.delete_if {|m| m.id == id}
      true
    end

    # @return [Hash]
    def to_h
      @mod_list.map {|m| m.to_h}
    end

    alias_method :to_hash, :to_h

  end
end


# mod_list = Arkrb::Mods.new
#
# pp mod_list
# mod_a = 731604991
# mod_b = 812655342
#
# mod_list.add(731604991)
# mod_list.add(812655342)
# pp mod_list.to_h
# # mod_list.add(731604991)
# # pp mod_list.find_by_id(mod_a).to_h