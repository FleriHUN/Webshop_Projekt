import { HttpEvent, HttpEventType, HttpHandlerFn, HttpRequest } from "@angular/common/http";
import { inject } from "@angular/core";
import { CookieService } from "ngx-cookie-service";
import { Observable, tap } from "rxjs";

export function CookieSetterInterceptor(req: HttpRequest<unknown>, next: HttpHandlerFn): Observable<HttpEvent<unknown>> {
  const cookieService = inject(CookieService)

  return next(req).pipe(
    tap((event) => {
      if (event.type === HttpEventType.Response) {
       console.log(event)
       
        const jwtToken: string | null = event.headers.get("bearer")

        if (jwtToken != null) {
          cookieService.set("jwt", jwtToken)
        }

        const refreshToken: string | null = event.headers.get("refreshToken")
        console.log("refreshToken: ", refreshToken)
        console.log("jwtToken: ", jwtToken)
        
        if (refreshToken != null) {
          cookieService.set("refreshToken", refreshToken)
        }
      }
    })
  )
}
