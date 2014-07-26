module WeeklyUpdate
  class BrewMailer

    def initialize
      weekly_pledged_projects = Pledge.where(created_at: 1.week.ago..Date.today).pluck(:project_id)
      @weekly_project_pledge_totals = Reward.where(project_id: weekly_funded_projects).group('project_id').sum('amount')
    end

    def printme
      puts @weekly_project_pledge_totals 
    end

  end
end