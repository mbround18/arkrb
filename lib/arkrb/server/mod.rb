require 'oga'
require 'open-uri'
require 'digest/md5'
module Arkrb
  class Mod
    def initialize(mod_id)
      @id = mod_id.to_i
      @workshop_url = "https://steamcommunity.com/sharedfiles/filedetails/?id=#{mod_id}"
      @changelog_url = "https://steamcommunity.com/sharedfiles/filedetails/changelog/#{mod_id}"

      does_mod_exist?

      @name = update_mod_name
      @version_tag = latest_version_tag
    end

    attr :id, :name, :version_tag, :workshop_url, :changelog_url

    def update_info
      self.name = update_mod_name
      self.version = latest_version_tag
    end

    def update_mod_name
      document = Oga.parse_html(open(changelog_url))
      document.at_css('div[class="workshopItemTitle"]').text
    end

    def latest_version_tag
      document = Oga.parse_html(open(changelog_url))
      version = document.at_css('div[class~="workshopAnnouncement"]:nth-child(3) > div[class="headline"]').text.strip
      Digest::MD5.hexdigest(version).strip
    end

    def does_mod_exist?
      document = Oga.parse_html(open(workshop_url))
      if document.at_css('div[class="error_ctn"] h3').text == 'That item does not exist.  It may have been removed by the author.'
        raise Arkrb::Error::ModDoesNotExist, "Woah the mod #{id} does not exist!"
      end
    rescue NoMethodError
      true
    end

    def to_h
      {
          id: id,
          name: name,
          version_tag: version_tag,
          workshop_url: workshop_url,
          changelog_url: changelog_url
      }
    end

    alias_method :to_hash, :to_h

  end
end