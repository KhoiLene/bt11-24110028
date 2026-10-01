package vn.edu.ute.config;

import com.opensymphony.sitemesh.webapp.SiteMeshFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * Cấu hình Web MVC, SiteMesh Filter và Interceptors - MSSV: 24110028
 */
@Configuration
public class WebConfig_24110028 implements WebMvcConfigurer {

    private final AdminAuthInterceptor_24110028 adminAuthInterceptor;

    @Autowired
    public WebConfig_24110028(AdminAuthInterceptor_24110028 adminAuthInterceptor) {
        this.adminAuthInterceptor = adminAuthInterceptor;
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(adminAuthInterceptor)
                .addPathPatterns("/admin/**");
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/static/**")
                .addResourceLocations("/static/", "classpath:/static/");
    }

    @Bean
    public FilterRegistrationBean<SiteMeshFilter> siteMeshFilter() {
        FilterRegistrationBean<SiteMeshFilter> filter = new FilterRegistrationBean<>();
        filter.setFilter(new SiteMeshFilter());
        filter.addUrlPatterns("/*");
        filter.setOrder(1);
        return filter;
    }
}
