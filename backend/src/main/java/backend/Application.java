package backend;

import io.micronaut.runtime.Micronaut;
import frontend.Library;

public class Application {

    public static void main(String[] args) {
        new Library();
        Micronaut.run(Application.class);
    }
}