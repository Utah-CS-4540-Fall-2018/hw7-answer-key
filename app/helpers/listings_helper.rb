module ListingsHelper

  def show_mass_edit_options
    ("<span id='mass-edit-label'>" +
        'Set checked listings to: ' + 
      "</span>" +
      "<span id='mass-edit-buttons'>" + 
        "<button id='set-checked-to-new' class='btn btn-default btn-xs' data-status='not_yet_seen'>New</button>" +
        "<button id='set-checked-to-watch' class='btn btn-default btn-xs' data-status='watch'>Watch</button>" +
        "<button id='set-checked-to-ignore' class='btn btn-default btn-xs' data-status='ignore'>Ignore</button>" +
      "</span>").html_safe
  end

  def show_selection_options
    s = "<span id='listings-selection-label'>Filter:</span>" +
        "<span id='listings-selection-buttons'>"

    # add a button for each of the possible statuses plus "All"
    possible_statuses = Listing.statuses.keys << "all"
    possible_statuses.each { |status|
      # make the currently selected filter look different
      styling_classes = 'btn btn-xs'
      # this is a little tricky because "all" == session[:listings_filter] being nil
      # so we need some extra logic here
      #
      # is the session[:listings_filter] nil?
      if session[:listings_filter].blank?
        # yes - meaning we should style the All button as selected
        if status == 'all'
          styling_classes += ' btn-primary'
        else
          styling_classes += ' btn-default'
        end
      else
        # no - style the button that matches the session[:listings_filter] as selected
        if status == session[:listings_filter]
          styling_classes += ' btn-primary'
        else
          styling_classes += ' btn-default'
        end
      end

      # one other tweak -- not_yet_seen is ugly...translate it to New
      # the not_yet_seen status should be shown as 'New'
      if status == 'not_yet_seen' 
        label = 'New' 
      else 
        label = status.capitalize
      end

      btn_str = "<button " +
        "id='select-#{status}' " +
        "class='#{styling_classes}' " +
        "data-filter='#{status}'>" +
        "#{label}" +
        "</button>"
      s += btn_str
    }
    s += "</span>"
    s.html_safe
  end

  def status_to_icon(s)
    case s 
    when :not_yet_seen, 'not_yet_seen'
      fa_icon("plus-circle")
    when :watch, 'watch'
      fa_icon("binoculars")
    when :ignore, 'ignore'
      fa_icon("eye-slash")
    end
  end

end
