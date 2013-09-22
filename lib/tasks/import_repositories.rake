# Still need some fixes (Sometimes it just doesn't work. Probably auth issues with GitHub)
ACCESS_TOKEN = "2ecc65f8e62cc41be532c1395f9a8762b373487d"
REPOSITORIES_URL = "https://api.github.com/repositories"

namespace :repos do
  desc "Import repositores from Github"

  task :import => :environment do
    repositories = get_json_from(REPOSITORIES_URL)

    repositories.each do |repo|
      languages = get_json_from(repo["languages_url"]).keys

      next if languages.empty?

      data = {
        name: repo["name"],
        login: repo["owner"]["login"],
        avatar_url: repo["owner"]["avatar_url"],
        repo_url: repo["html_url"],
        description: repo["description"],
        languages: languages
      }

      Repository.where(repo_url: data[:repo_url]).find_or_create_by(data)
    end
  end
end

def get_json_from(url)
  JSON.parse(RestClient.get(url, access_token: ACCESS_TOKEN))
end