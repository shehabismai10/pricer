import json
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from . import scraper

@csrf_exempt
def compare_products_api(request):
    if request.method == 'POST':
        # Check if request body is empty
        if not request.body:
            return JsonResponse({'error': 'Request body is empty'}, status=400)
        
        try:
            # Get the JSON data from the request body
            data = json.loads(request.body.decode('utf-8'))
            search_string = data.get('search_string', '')

            if not search_string:
                return JsonResponse({'error': 'Please provide a search string'}, status=400)

            # Call web scraping functions from the scraper module
            amazon_products = scraper.getAmazonData(search_string)
            noon_products = scraper.getNoonData("https://www.noon.com/egypt-en/search/?q=" + search_string)
            btech_products = scraper.getBtechData("https://btech.com/ar/catalogsearch/result/?q=" + search_string)
            dubizzle_products = scraper.getDubizzeleData(search_string)

            # Prepare the response JSON
            response_data = {
                'amazon_products': amazon_products,
                'noon_products': noon_products,
                'btech_products': btech_products,
                'dubizzle_products': dubizzle_products,
            }

            # Return the response as JSON
            return JsonResponse(response_data)
        except json.JSONDecodeError:
            return JsonResponse({'error': 'Invalid JSON data in request body'}, status=400)
        except Exception as e:
            return JsonResponse({'error': f'Error while processing request: {str(e)}'}, status=500)
    else:
        # Return an error response if the request method is not POST
        return JsonResponse({'error': 'Only POST requests are allowed'}, status=405)
