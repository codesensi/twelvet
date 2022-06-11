package com.twelvet.framework.security.feign;

import cn.hutool.core.util.StrUtil;
import com.twelvet.framework.utils.$;
import com.twelvet.framework.utils.http.IpUtils;
import com.twelvet.framework.utils.http.ServletUtils;
import feign.RequestInterceptor;
import feign.RequestTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.security.oauth2.core.OAuth2AccessToken;
import org.springframework.security.oauth2.server.resource.web.BearerTokenResolver;
import org.springframework.stereotype.Component;
import org.springframework.web.util.WebUtils;

import javax.servlet.http.HttpServletRequest;
import java.util.Enumeration;

/**
 * @author twelvet
 * @WebSite www.twelvet.cn
 * @Description: Feign 请求拦截器
 */
@Component
public class FeignRequestInterceptor implements RequestInterceptor {

    @Autowired
    private BearerTokenResolver tokenResolver;

    /**
     * 配置请求体带上access_token(feign默认不带任何信息)
     *
     * @param requestTemplate RequestTemplate
     */
    @Override
    public void apply(RequestTemplate requestTemplate) {

        // 配置客户端IP
        requestTemplate.header("X-Forwarded-For", IpUtils.getIpAddr());

        // 非web 请求直接跳过
        if ($.isEmpty(ServletUtils.getRequest())) {
            return;
        }
        HttpServletRequest request = ServletUtils.getRequest();
        Enumeration<String> headerNames = request.getHeaderNames();
        // 装载web请求所有头部
        if (headerNames != null) {
            while (headerNames.hasMoreElements()) {
                String name = headerNames.nextElement();
                String values = request.getHeader(name);
                requestTemplate.header(name, values);

            }
        }

        // 避免请求参数的 query token 无法传递
        String token = tokenResolver.resolve(request);
        if (StrUtil.isBlank(token)) {
            return;
        }

        requestTemplate.header(HttpHeaders.AUTHORIZATION, String.format("%s %s", OAuth2AccessToken.TokenType.BEARER, token));
    }

}