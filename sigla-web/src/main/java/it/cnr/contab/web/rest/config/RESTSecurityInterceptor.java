package it.cnr.contab.web.rest.config;

import it.cnr.contab.utenze00.bp.RESTUserContext;
import it.cnr.contab.utenze00.bulk.UtenteBulk;
import it.cnr.contab.web.rest.exception.RestException;
import it.cnr.jada.UserContext;
import it.cnr.jada.comp.ComponentException;

import java.lang.reflect.Method;
import java.rmi.RemoteException;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import javax.annotation.security.DenyAll;
import javax.annotation.security.PermitAll;
import javax.annotation.security.RolesAllowed;
import javax.ejb.EJBException;
import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.container.ContainerRequestFilter;
import javax.ws.rs.container.ResourceInfo;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MultivaluedMap;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;
import javax.ws.rs.ext.Providers;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Provider
public class RESTSecurityInterceptor implements ContainerRequestFilter, ExceptionMapper<Exception> {

	private Logger LOGGER = LoggerFactory.getLogger(RESTSecurityInterceptor.class);
	@Context
	private ResourceInfo resourceInfo;
    @Context
    private Providers providers;
    
	private static final String AUTHORIZATION_PROPERTY = "Authorization";
	private final static Map<String, String> UNAUTHORIZED_MAP = Collections.singletonMap("ERROR", "User cannot access the resource.");
	@Override
	public void filter(ContainerRequestContext requestContext) {	

		final Method method = resourceInfo.getResourceMethod();
		final Class<?> declaring = resourceInfo.getResourceClass();		
		String[] rolesAllowed = null;
		boolean denyAll;
		boolean permitAll;
		RolesAllowed allowed = declaring.getAnnotation(RolesAllowed.class),
			methodAllowed = method.getAnnotation(RolesAllowed.class);
		if (methodAllowed != null) allowed = methodAllowed;
		if (allowed != null)
		{
			rolesAllowed = allowed.value();
		}
		AccessoAllowed accessoAllowed = declaring.getAnnotation(AccessoAllowed.class),
				accessoMethodAllowed = method.getAnnotation(AccessoAllowed.class);
		if (accessoMethodAllowed != null) accessoAllowed = accessoMethodAllowed;

		
		denyAll = (declaring.isAnnotationPresent(DenyAll.class)
				&& method.isAnnotationPresent(RolesAllowed.class) == false
				&& method.isAnnotationPresent(PermitAll.class) == false) || method.isAnnotationPresent(DenyAll.class);

		permitAll = (declaring.isAnnotationPresent(PermitAll.class) == true
				&& method.isAnnotationPresent(RolesAllowed.class) == false
				&& method.isAnnotationPresent(DenyAll.class) == false) || method.isAnnotationPresent(PermitAll.class);
		
		UtenteBulk utenteBulk = null;		
		if (rolesAllowed != null || accessoAllowed != null) {
			final MultivaluedMap<String, String> headers = requestContext.getHeaders();
			final List<String> authorization = headers.get(AUTHORIZATION_PROPERTY);
			try {
				utenteBulk = BasicAuthentication.authenticate(authorization);
				if (utenteBulk == null){
					requestContext.abortWith(Response.status(Status.UNAUTHORIZED).entity(UNAUTHORIZED_MAP).build());
					return;
				}
		    	requestContext.setSecurityContext(new SIGLASecurityContext(requestContext, utenteBulk.getCd_utente()));
			} catch (Exception e) {
				LOGGER.error("ERROR for REST SERVICE", e);
				requestContext.abortWith(Response.status(Status.INTERNAL_SERVER_ERROR).entity(e).build());
				return;
			}			
		}		
		if (rolesAllowed != null || denyAll || permitAll) {
			if (denyAll) {
				requestContext.abortWith(Response.status(Status.FORBIDDEN).entity(UNAUTHORIZED_MAP).build());
				return;
			}
			if (permitAll) return;
		    if (rolesAllowed != null) {
				Set<String> rolesSet = new HashSet<String>(
						Arrays.asList(rolesAllowed));
				try {
					if (!isUserAllowed(utenteBulk, rolesSet)) {
						requestContext.abortWith(Response.status(Status.UNAUTHORIZED).entity(Collections.singletonMap("ERROR", "User doesn't have the following roles: " + rolesSet)).build());
						return;
					}
				} catch (Exception e) {
					requestContext.abortWith(Response.status(Status.INTERNAL_SERVER_ERROR).entity(e).build());
				}		    	
		    }			
		}
		if (accessoAllowed != null) {
			List<String> accessi = Stream.of(accessoAllowed.value()).map(x -> x.name()).collect(Collectors.toList());
			try {
				if (!BasicAuthentication.loginComponentSession().isUserAccessoAllowed(
						(UserContext)requestContext.getSecurityContext().getUserPrincipal(), 
						accessi.toArray(new String[accessi.size()]))) {
					requestContext.abortWith(Response.status(Status.UNAUTHORIZED).entity(Collections.singletonMap("ERROR", "User doesn't have the following access: " + accessi)).build());
				}
			} catch (ComponentException|RemoteException|EJBException e) {
				requestContext.abortWith(Response.status(Status.INTERNAL_SERVER_ERROR).entity(e).build());
			}
		}
	}
    
	private boolean isUserAllowed(final UtenteBulk utente,
			final Set<String> rolesSet) throws Exception{
		try {
			return Optional.ofNullable(BasicAuthentication.getRuoli(new RESTUserContext(), utente))
					.map(x -> x.stream())
					.get()
					.filter(x -> rolesSet.contains(x.getCd_ruolo())).count() > 0;
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public Response toResponse(Exception exception) {
		LOGGER.error("ERROR for REST SERVICE", exception);
		if (exception instanceof RestException)
			return Response.status(((RestException)exception).getStatus()).entity(((RestException)exception).getErrorMap()).build();			
		return Response.status(Status.INTERNAL_SERVER_ERROR).entity(exception).build();
	}
}