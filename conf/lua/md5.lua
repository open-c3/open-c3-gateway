if ngx.var.cookie_session then
    local md5 = ngx.md5(ngx.var.cookie_session)
    if not ( ngx.var.cookie_session == "cookietimeout" ) then
        ngx.log(ngx.ERR, "cookieinfo:[", os.time(), ":",md5,"]")
    end
    return md5

end

return "md5null"
