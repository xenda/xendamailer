class Story < ActiveResource::Base
  self.site = "http://www.pivotaltracker.com/services/v3/projects/:project_id"
  headers['X-TrackerToken'] = '78050863bdc2667869fecc1308ca5621'
end
