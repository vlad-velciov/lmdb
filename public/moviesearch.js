const MovieSearch = () => {
    class Query {
        constructor() {
            this.input = document.getElementById('q');
            this.movieList = new MovieList();
            this.delayService = new Delay();
            this.movieRepository = new MovieRepository();
        }

        watchQuery() {
            this.input.addEventListener('keydown', (ev) => {
                if((ev.which < 65 || ev.which > 90) // Letters
                    && ev.which !== 32 // Space
                    && ev.which !== 8) // Backspace
                {
                    return;
                }
                this.delayService.performLater(this.search.bind(this));
            });
        }

        set(query) {
            this.input.value = query;
            this.search();
        }

        search() {
            const query = this.getQuery();
            this.searchForTitle(query).subscribe(
                (movies) => { this.showResults(movies) },
                (error) => { console.log('There was an error:', error)
            });
        }

        getQuery() {
            return this.input.value;
        }

        getStrategy() {
            return document.querySelector('input[name="strategy"]:checked').value;
        }

        searchForTitle(title) {
            return this.movieRepository.findByTitle(title, this.getStrategy());
        }

        showResults(movies) {
            this.movieList.show(movies);
        }
    }

    class MovieList {
        constructor() {
            this.listUi = document.getElementById('results');
        }

        show(movies) {
            this.empty();

            movies.forEach((movie) => {
                const element = this.getResultElementFor(movie);
                this.append(element);
            });
        }

        empty() {
            this.listUi.innerHTML = '';
        }

        getResultElementFor(movie) {
            const template = document.createElement('template');
            const asString = '<li class="list-group-item">' + movie.originalTitle + '</li>';

            template.innerHTML = asString;
            return template.content.firstChild;
        }

        append(listItem) {
            this.listUi.appendChild(listItem);
        }
    }

    class Delay {
        constructor() {
            this.interval = null;
        }

        performLater(callback) {
            clearInterval(this.interval);
            this.interval = setTimeout(callback, 500);
        }
    }

    class MovieRepository {
        constructor() {
            this.endpoint = '/movies';
            this.previousRequest = null;
        }

        findByTitle(title, strategy) {
            this.abort();
            const xhr = new XMLHttpRequest();
            const url = this.endpoint + '?title=' + title + '&strategy=' + strategy;
            this.previousRequest = xhr;

            xhr.open('GET', url, true);

            return new XhrObserver(xhr);
        }

        abort() {
            if(this.previousRequest  === null
                || typeof(this.previousRequest) === 'undefined') {
                return;
            }
            this.previousRequest.abort();
        }
    }

    class XhrObserver {
        constructor(xhr) {
            this.xhr = xhr;
        }

        subscribe(success, error) {
            this.xhr.onreadystatechange =  () => {
                if(this.xhr.readyState === 4) {
                    if(
                        this.xhr.status >=200
                        && this.xhr.status < 400
                        && typeof(success) === 'function'
                    ) {
                        var response = JSON.parse(this.xhr.responseText);
                        success(response);
                    } else if(typeof(error) === 'function') {
                        error(this.xhr.responseText);
                    }
                }
            };
            this.xhr.send();
        }
    }

    const q = new Query();
    q.watchQuery();

    const urlParams = new URLSearchParams(window.location.search);
    q.set(urlParams.get('q'));
};



