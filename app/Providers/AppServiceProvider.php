<?php

namespace App\Providers;

use App\Observers\PurchaseOrderObserver;
use App\Observers\QuoteObserver;
use App\PurchaseOrder;
use App\Quote;
use Illuminate\Support\Facades\Blade;
use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Collection;
use Illuminate\Pagination\LengthAwarePaginator;
use NumberToWords\NumberToWords;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        //
    }

    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        /**
         * Paginate a standard Laravel Collection.
         *
         * @param int $perPage
         * @param int $total
         * @param int $page
         * @param string $pageName
         * @return array
         */
        Collection::macro('paginate', function($perPage, $total = null, $page = null, $pageName = 'page') {
            $page = $page ?: LengthAwarePaginator::resolveCurrentPage($pageName);

            return new LengthAwarePaginator(
                $this->forPage($page, $perPage),
                $total ?: $this->count(),
                $perPage,
                $page,
                [
                    'path' => LengthAwarePaginator::resolveCurrentPath(),
                    'pageName' => $pageName,
                ]
            );
        });

        Quote::observe(QuoteObserver::class);

        Blade::directive('convert', function ($money) {
            return "<?php echo '$' . number_format($money, 2); ?>";
        });

        Blade::directive('numberToWords', function ($number){
            $numberToWords = new NumberToWords();
            $numberTransformer = $numberToWords->getNumberTransformer('fr');
            return $numberTransformer->toWords($number);
//            return "decima";
        });

        PurchaseOrder::observe(PurchaseOrderObserver::class);


    }
}
