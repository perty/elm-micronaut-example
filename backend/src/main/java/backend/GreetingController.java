package backend;

import io.micronaut.http.annotation.Controller;
import io.micronaut.http.annotation.Get;

@Controller("/greeting")
public class GreetingController {

    @Get
    public Greeting getGreeting() {
        Greeting greeting = new Greeting();
        greeting.setId(42);
        greeting.setContent("some content");

        return greeting;
    }
}
