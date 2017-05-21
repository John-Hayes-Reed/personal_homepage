class GenerateRecentActivity
  include BottledObserver

  def call
    return unless @options[:source].present?

  end

  private

  def define_title
    if @options[:source].is_a? Project
      'Project information updated'
    end
  end
end