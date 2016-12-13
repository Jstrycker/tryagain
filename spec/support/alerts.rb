def have_alert(alert_type, option = {})
        have_selector(".ALERT- #{alert_type}", options)
end
